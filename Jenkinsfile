pipeline {
    agent any
    environment {
        SiteName = "CoreWebApp"
    }
    stages{
        stage("Check Stage Information") {
            when {
                branch 'stage'             
            }
            steps {
                script {
                    env.WindowsServer = "QA"
                    env.AgentLabel = "qa-windows-agent"
                    env.publishPath = "D:/inetpub/wwwroot/${env.SiteName}"
                    env.newItemPath = "D:/inetpub/wwwroot/MAL/logs"
                    env.icalcPath = "D:/inetpub/wwwroot/MAL"
                    //env.DeployPath = "C:/jenkins-agent/workspace/My_Portal_Pipeline_stage/${env.SiteName}/${env.PackageName}"
                } 
            }
        }
        stage("Check Prod Information"){
            when {
                branch 'master'             
            }
            steps {
                script {
                    env.WindowsServer = "PROD"
                    env.AgentLabel = "prod-windows-agent"
                    env.publishPath = "D:/inetpub/MyWindDashboard/${env.SiteName}"
                    env.newItemPath = "D:/inetpub/MyWindDashboard/MAL/logs"
                    env.icalcPath = "D:/inetpub/MyWindDashboard/MAL"
                    //env.DeployPath = "C:/jenkins-agent/workspace/My_Portal_Pipeline_stage/${env.SiteName}/${env.PackageName}"
                } 
            }
        }
        stage("Start"){
            agent { node { label env.AgentLabel } }
            stages(){
                stage('Clean And Build') {    
                    steps {
                        bat "dotnet restore ./${env.SiteName}/${env.SiteName}.csproj"
                        bat "dotnet clean"
                        bat "dotnet build --configuration Release"
                    }
                }
                stage('MAL Backup') {
                    steps {
                        script{
                            try{
                                powershell "./PS_Scripts/${env.WindowsServer}/BackupCoreWebApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('Stop App'){
                    steps{
                        script{
                            try{
                                powershell "./PS_Scripts/${env.WindowsServer}/StopApp.ps1"
                            } catch (err){
                                echo err.getMessage()
                            }
                        }
                    }
                }
                stage('Publish on IIS') {
                    steps {
                        bat "dotnet publish ./${env.SiteName}/${env.SiteName}.csproj --output ${env.publishPath}"
                    }
                }
                stage('Replace Web Config') {
                    steps {
                        powershell "Copy-Item ./web.config -Destination ${env.publishPath}"
                    }
                }
                stage('Convert to Web App') {
                    steps {
                        powershell "./PS_Scripts/${env.WindowsServer}/ConvertApp.ps1"
                        powershell "New-Item ${env.newItemPath} -itemType Directory"
                        bat "cmd /c icacls ${env.icalcPath} /grant Everyone:(OI)(CI)F"
                    }
                }
            }
        }
    }
}