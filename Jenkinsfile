pipeline {
    agent any
    environment {
        SiteName = "CoreWebApp"
    }
    
    // GLOBAL STAGES
    stages{
        // QA STEPS
        stage("QA Steps"){
            when {
                beforeAgent true
                branch "stage"
            }

            agent { node { label 'qa-windows-agent' } }  
            // LIST OF QA Stages
            stages(){
                stage('QA Clean And Build') {    
                    steps {
                        bat "dotnet restore ./${env.SiteName}/${env.SiteName}.csproj"
                        bat "dotnet clean"
                        bat "dotnet build --configuration Release"
                    }
                }
                stage('QA MAL Backup') {
                    steps {
                        script{
                            try{
                                powershell "./PS_Scripts/QA/BackupCoreWebApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('QA Stop App'){
                    steps{
                        script{
                            try{
                                powershell "./PS_Scripts/QA/StopApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('QA Publish on IIS') {
                    steps {
                        bat "dotnet publish ./${env.SiteName}/${env.SiteName}.csproj --output D:/inetpub/wwwroot/${env.SiteName}"
                    }
                }
                stage('QA Replace Web Config') {
                    steps {
                        powershell "Copy-Item ./web.config -Destination D:/inetpub/wwwroot/${env.SiteName}"
                    }
                }
                stage('QA Convert to Web App') {
                    steps {
                        powershell "./PS_Scripts/QA/ConvertApp.ps1"
                        powershell "New-Item D:/inetpub/wwwroot/MAL/logs -itemType Directory"
                        bat "cmd /c icacls D:/inetpub/wwwroot/MAL /grant Everyone:(OI)(CI)F"
                    }
                }
            }
        }
        // PROD STEPS
        stage("PROD Steps"){
            when {
                beforeAgent true
                branch "master"
            }
            agent { node { label 'prod-windows-agent' } }  
            // LIST OF PROD Stages
            stages(){
                stage('PROD Clean And Build') {    
                    steps {
                        bat "dotnet restore ./${env.SiteName}/${env.SiteName}.csproj"
                        bat "dotnet clean"
                        bat "dotnet build --configuration Release"
                    }
                }
                stage('PROD MAL Backup') {
                    steps {
                        script{
                            try{
                                powershell "./PS_Scripts/PROD/BackupCoreWebApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('PROD Stop App'){
                    steps{
                        script{
                            try{
                                powershell "./PS_Scripts/PROD/StopApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('PROD Publish on IIS') {
                    steps {
                        bat "dotnet publish ./${env.SiteName}/${env.SiteName}.csproj --output D:/inetpub/MyWindDashboard/${env.SiteName}"
                    }
                }
                stage('PROD Replace Web Config') {
                    steps {
                        powershell "Copy-Item ./web.config -Destination D:/inetpub/MyWindDashboard/${env.SiteName}"
                    }
                }
                stage('PROD Convert to Web App') {
                    steps {
                        powershell "./PS_Scripts/PROD/ConvertApp.ps1"
                        powershell "New-Item D:/inetpub/MyWindDashboard/MAL/logs -itemType Directory"
                        bat "cmd /c icacls D:/inetpub/MyWindDashboard/MAL /grant Everyone:(OI)(CI)F"
                    }
                }
            }
        }
    }
}