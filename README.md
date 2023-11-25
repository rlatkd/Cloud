# Development Operations project using AWS & Terraform & GitHub Actions

## 0. 목차

- [개요](#1-개요)
- [Amazon Web Service](#2-Amazon-Web-Service)
- [Terraform](#3-Terraform)
- [Github Actions & AWS CodeDeploy](#4-Github-Actions--AWS-CodeDeploy)
- [후기](#5-후기)

## 1. 개요

### 1.1 프로젝트 개요

- 프로젝트 이름: DevOps
- 프로젝트 목적:
  - 기존의 SSGBay 애플리케이션을 AWS에 배포
  - Terraform을 이용해 인프라를 코드로 자동 구성
  - GitHub Actions와 AWS CodeDeploy를 이용해 CI/CD 파이프라인 구축
  - 해당 서비스 앱의 main branch에서 커밋하면 자동으로 배포
- 프로젝트 기간: 2023.11.22 ~ 진행중(Terraform)

### 1.2 서비스

**(1) Deployment**

- Amazon Web Service (EC2, S3, RDS)

**(2) Iac (Infrastructure as Code)**

- Terraform

**(3) CI/CD (Continuous Integration/Continuos Delivery)**

- GitHub Actions & AWS CodeDeploy

### 1.3 프로젝트 진행 과정

| 일별                    | 내용                                  |
| ----------------------- | ------------------------------------- |
| 1일차 (11.22)           | - AWS를 이용한 기본 배포              |
| 2일차 (11.23)           | - Terraform을 이용한 인프라 구축      |
| 3~4일차 (11.24 ~ 11.25) | - GitHub Actions를 이용한 배포 자동화 |
| 7일차 (11.01)           | - 44                                  |
| 8일차 (11.02)           | - 55                                  |

### 1.4 전체 구조

**(1) Frontend GitHub Repository**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/devopsReact.jpg">

```
📁 client
 ├──── 📁 .github
 │      └──── 📁 workflows
 │             └──── 📄 deploy.yml
 │             └──── 📄 deploy.yml
...
...
```

**(2) Backend GitHub Repository**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/devopsFlask.jpg">

```
📁 server
 ├──── 📁 .github
 │      └──── 📁 workflows
 │             └──── 📄 deploy.yml
 ├──── 📁 scripts
 │      ├──── 📄 afterInstall.sh
 │      ├──── 📄 beforeInstall.sh
 │      └──── 📄 runServer.sh
 ├─────────── 📄 appspec.yml
...
...

```

**(3) 디렉터리 구조**

- workflows/deploy.yml

  - Github Actions를 이용해 자동화한 작업 과정
  - 폴더 아래에 위치한 YAML 파일로 작업 과정을 설정
  - 하나의 코드 저장소(GitHub Repository)에 여러 개의 워크플로우 설정이 가능
  - 해당 워크플로우는 `on` 속성을 이용해 언제 실행되는지와 `job` 속성을 이용해 구체적으로 어떤 일을 하는지 명시

- appspec.yml

  - AWS CodeDeploy를 이용해 자동화한 작업 과정
  - React 앱은 Amazon EC2가 아닌 Amazon S3 버킷에 정적 상태로 저장하기 때문에 사용하지 않음

- scripts

  - appspec.yml에 사용할 shell script들이 있는 폴더

## 2. Amazon Web Service

### 2.1 Frontend (Amazon S3 Bucket)

**(1) 초기 설정**

- rlatkdReact 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactUser.jpg">

**(2) S3 Bucket 설정**

- S3 Bucket 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket3.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket4.jpg">

- 정적 웹 사이트 호스팅 활성화

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/staticWebHostingActivate1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/staticWebHostingActivate2.jpg">

- 버킷과 객체에 퍼블릭 액세스 권한 부여

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority3.jpg">

**(3) S3 Bucket에 배포**

- React 앱 빌드

```
.\client>npm install
.\client>npm run build

.\CLIENT\BUILD
│   asset-manifest.json
│   favicon.ico
│   index.html
│   logo192.png
│   logo512.png
│   manifest.json
│   robots.txt
│
└───static
    ├───css
    │       main.3b876a84.css
    │       main.3b876a84.css.map
    │
    └───js
            787.cda612ba.chunk.js
            787.cda612ba.chunk.js.map
            main.37105d08.js
            main.37105d08.js.LICENSE.txt
            main.37105d08.js.map
```

- 빌드한 React 앱 소스 코드를 S3 Bucket에 등록

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactCodeToBucket1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactCodeToBucket2.jpg">

**(4) 서비스 정상 작동 확인**

- 브라우저로 S3 Bucket의 웹 사이트 앤드포인트로 접근

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/bucketEndpoint.jpg">

# CloudFront 해야함

###

### 2.2 Backend (Amazon EC2)

**(1) 초기 설정**

- rlatkdFlask 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/addFlaskUser.jpg">

- VPC 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createVPC.jpg">

- 보안 그룹 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createSg.jpg">

**(2) EC2 Instance 설정**

- Public Subnet에 EC2 Instance를 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance3.jpg">

- EC2 Instance의 Public IP 주소로 SSH 접속

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/accessSSH.jpg">

- Apache HTTP Server 설치

```
ubuntu@ip-10-0-3-255:~$ sudo apt update
ubuntu@ip-10-0-3-255:~$ sudo apt -y upgrade
ubuntu@ip-10-0-3-255:~$ sudo apt install -y apache2
ubuntu@ip-10-0-3-255:~$ sudo systemctl status apache2
ubuntu@ip-10-0-3-255:~$ sudo systemctl status apache2

● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2023-11-22 09:37:20 UTC; 8s ago
       Docs: https://httpd.apache.org/docs/2.4/
   Main PID: 14846 (apache2)
      Tasks: 55 (limit: 1121)
     Memory: 5.0M
        CPU: 33ms
     CGroup: /system.slice/apache2.service
             ├─14846 /usr/sbin/apache2 -k start
             ├─14848 /usr/sbin/apache2 -k start
             └─14849 /usr/sbin/apache2 -k start

Nov 22 09:37:20 ip-10-0-3-255 systemd[1]: Starting The Apache HTTP Server...
Nov 22 09:37:20 ip-10-0-3-255 systemd[1]: Started The Apache HTTP Server.
```

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/installApache.jpg">

- PHP 설치

```
ubuntu@ip-10-0-3-255:~$ sudo apt install -y php
ubuntu@ip-10-0-3-255:~$ sudo systemctl restart apache2
ubuntu@ip-10-0-3-255:~$ sudo systemctl status apache2

● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2023-11-22 09:40:07 UTC; 3s ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 21605 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
   Main PID: 21609 (apache2)
      Tasks: 6 (limit: 1121)
     Memory: 10.0M
        CPU: 47ms
     CGroup: /system.slice/apache2.service
             ├─21609 /usr/sbin/apache2 -k start
             ├─21610 /usr/sbin/apache2 -k start
             ├─21611 /usr/sbin/apache2 -k start
             ├─21612 /usr/sbin/apache2 -k start
             ├─21613 /usr/sbin/apache2 -k start
             └─21614 /usr/sbin/apache2 -k start

Nov 22 09:40:07 ip-10-0-3-255 systemd[1]: Starting The Apache HTTP Server...
Nov 22 09:40:07 ip-10-0-3-255 systemd[1]: Started The Apache HTTP Server.
```

- 웹 루트 디렉터리 삭제

```
ubuntu@ip-10-0-3-255:~$ cd /var/www/html/
ubuntu@ip-10-0-3-255:/var/www/html$ ls
index.html

ubuntu@ip-10-0-3-255:/var/www/html$ sudo rm -rf *
ubuntu@ip-10-0-3-255:/var/www/html$ ls
```

### 2.3 Database (Amazon RDS)

**(1) 초기 설정**

- rlatkdMySQL 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/addMySQLUser.jpg">

**(2) RDS 설정**

- Private Subnet에 RDS를 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS3.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS4.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS5.jpg">

- RDS에서 Flask EC2 Instance로의 연결 설정

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance3.jpg">

- Flask EC2 Instance는 Backend server를 포함하며 Bastion Host 역할을 함

  - Bastion Host
    - 1

- MySQL Workbench를 실행해서 RDS로의 연결 설정

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectWorkbench.jpg">

**(3) Database 설정**

- MySQL Workbench에서 schema 및 table 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createSchemaTable.jpg">

# Terraform 해야됨

## 3. Terraform

### 3.1

**(1) d**

## 4. Github Actions & AWS CodeDeploy

### 4.1 Frontend

**(1) d**

- GitHub Repository(DevOps-React)에 Secret을 추가

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/githubReposSecrets.jpg">

-
