# Development Operations project using AWS & Terraform & GitHub Actions

# 0. 목차

## [개요](#1-개요)

### 1.1 프로젝트 개요

### 1.2 서비스

(1) Deployment

(2) Iac (Infrastructure as Code)

(3) CI/CD (Continuous Integration/Continuos Delivery)

### 1.3 프로젝트 진행 과정

### 1.4 인프라 구조

### 1.5 전체 구조

(1) Frontend GitHub Repository

(2) Backend GitHub Repository

(3) 디렉터리 구조

### 1.6 AWS 설정 구조

(1) 계정 권한

(2) 키

(3) 그룹 당 규칙

(4) 역할

## [Amazon Web Service](#2-Amazon-Web-Service)

### 2.1 Frontend (Amazon S3)

(1) 초기 설정

(2) Amazon S3 설정

(3) Amazon S3에 배포

(4) 서비스 정상 작동 확인

### 2.2 Frontend (AWS CloudFront)

(1) Amazon S3만으로 정적 웹 호스팅을 서비스할 때 문제점

(2) AWS CloudFront

(3) 초기 설정

### 2.3 Backend (Amazon EC2)

(1) 초기 설정

(2) Amazon EC2 설정

### 2.4 Database (Amazon RDS)

(1) 초기 설정

(2) Amazon RDS 설정

(3) Database 설정

## [Terraform](#3-Terraform)

### 3.1 Terraform 설정

(1) 초기 설정-1

(2) 초기 설정-2

### 3.2 Terrform을 이용해 인프라 구성

(1) terraform apply

### 3.3 자동으로 구성된 인프라

(1) VPC 구성 확인

(2) Amazon EC2 확인

(3) Amazon S3 확인

(4) Amazon RDS 확인

## [Github Actions & AWS CodeDeploy](#4-Github-Actions--AWS-CodeDeploy)

### 4.1 Frontend

(1) GitHub Actions

(2) React test 코드를 삽입 후 GitHub에 commit 시 자동으로 배포

### 4.2 Backend

(1) AWS CodeDeploy

(2) GitHub Actions

(3) Flask test 코드를 삽입 후 GitHub에 commit 시 자동으로 배포

## [Trouble Shooting](#5-Trouble-Shooting)

### 5.1 Frontend

(1) autoprefixer

(2) eslint: img alt

(3) eslint: eqeqeq

### 5.2 Backend

(1) 배포했으나 연결할 수 없음

(2) 해결 방법

(3) 정상 작동 확인

### 5.3 Backend - Database

(1) Backend와 Database 연동이 안 됨

(2) 해결 방법

(3) 재 배포 시 정상으로 작동하는 것을 확인

### 5.4 Frontend - Backend

(1) Frotnend와 Backend 연동이 안 됨

(2) 해결 방법

(3) 재 배포 시 정상으로 작동하는 것을 확인

(4) SSL 인증-1

(5) SSL 인증-2

### 5.5 시연

(1) 이미지 업로드가 안 됨

(2) 직접 EC2 내부로 들어가서 작업

(3) 백그라운드로 실행시키고 있는 Flask를 종료 후 포그라운드로 실행한 다음 요청 및 응답을 확인

(4) 디렉터리가 존재하지 않는 이유

(5) AWS CodeDeploy를 잘못 이해하고 있었음

(6) 해결 방법

(7) 재 배포 시 정상적으로 작동하는 것을 확인

### 5.6 Crontab

(1) Crontab 작동이 안함

(2) 해결 방법

(3) 재 배포 시 정상적으로 작동하는 것을 확인

### 5.7 배포 시간 단축

(1) deploy.yml 템플릿 수정

(2) 캐시 설정 전

(3) 캐시 설정 후

## [후기](#6-후기)

# 1. 개요

## 1.1 프로젝트 개요

- **프로젝트 이름**: DevOps
- **프로젝트 목적**:
  - 기존의 SSGBay 애플리케이션을 AWS에 배포
  - Terraform을 이용해 인프라를 코드로 자동 구성
  - GitHub Actions와 AWS CodeDeploy를 이용해 CI/CD 파이프라인 구축
  - 해당 서비스 앱의 main branch에서 커밋하면 자동으로 배포
- **프로젝트 기간**: 2023.11.22 ~ 2023.11.28

## 1.2 서비스

### (1) Deployment

- Amazon Web Service (EC2, S3, RDS)

### (2) Iac (Infrastructure as Code)

- Terraform

### (3) CI/CD (Continuous Integration/Continuos Delivery)

- GitHub Actions & AWS CodeDeploy

## 1.3 프로젝트 진행 과정

| 일별                    | 내용                                                 |
| ----------------------- | ---------------------------------------------------- |
| 1일차 (11.22)           | AWS를 이용한 기본 배포                               |
| 2일차 (11.23)           | Terraform을 이용한 인프라 구축                       |
| 3일차 (11.24)           | GitHub Actions와 AWS CodeDeploy를 이용한 배포 자동화 |
| 4~7일차 (11.25 ~ 11.28) | Trouble Shooting                                     |

## 1.4 인프라 구조

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/infrastructure.jpg">

## 1.5 전체 구조

### (1) Frontend GitHub Repository

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

### (2) Backend GitHub Repository

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

### (3) 앱 디렉터리 구조

- **workflows/deploy.yml**

  - Github Actions를 이용해 자동화한 작업 과정
  - 폴더 아래에 위치한 YAML 파일로 작업 과정을 설정
  - 하나의 코드 저장소(GitHub Repository)에 여러 개의 워크플로우 설정이 가능
  - 해당 워크플로우는 `on` 속성을 이용해 언제 실행되는지와 `job` 속성을 이용해 구체적으로 어떤 일을 하는지 명시

- **appspec.yml**

  - AWS CodeDeploy를 이용해 자동화한 작업 과정
  - React 앱은 Amazon EC2가 아닌 Amazon S3에 정적 상태로 저장하기 때문에 사용하지 않음

- **scripts**

  - appspec.yml에 사용할 shell script들이 있는 폴더

### (4) Terraform GitHub Repository

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/devopsTerraform.jpg">

```
📁 terraform
 ├──── 📁 .terraform
 ├──── 📁 authority
 │      ├──── 📄 iamPolicyFlask.tf
 │      ├──── 📄 iamPolicyMySQL.tf
 │      ├──── 📄 iamPolicyReact.tf
 │      └──── 📄 rlatkdCodeDeployEC2Policy.tf
 ├──── 📁 module
 │      ├──── 📄 ec2.tf
 │      ├──── 📄 ec2RdsSg.tf
 │      ├──── 📄 ec2Sg.tf
 │      ├──── 📄 iam.tf
 │      ├──── 📄 rds.tf
 │      ├──── 📄 rdsEc2Sg.tf
 │      ├──── 📄 role.tf
 │      ├──── 📄 s3React.tf
 │      └──── 📄 vpc.tf
 ├─────────── 📄 .terraform.lock.hcl
 ├─────────── 📄 main.tf
 ├─────────── 📄 terraform.tfstate
 ├─────────── 📄 terraform.tfstate.backup
...
...
```

### (5) Terraform 디렉터리 구조

- **.terraform**

  - `terrform init` 명령어를 실행하면 프로바이더를 참조하여 해당 환경을 설정해주는 파일을 모아둔 폴더

- **authority**

  - 각 사용자 및 Amazon EC2에 쓰일 정책 모음 폴더

- **module**

  - 서비스 별로 나누어 권한, 정책, 생성 등을 명시한 폴더

- **.terraform.lock.hcl**

  - 파일 위치를 잠금으로서 두 작업이 비동기적으로 처리되게 설정하는 파일

  - `terrform init` 명령어를 실행할 때 마다 자동으로 생성하거나 업데이트

- **main.tf**

  - `terraform apply` 명령어를 실행하면 각 resource 들에 명시된대로 인프라 구성 및 설정

- **.terraform.tfstate**

  - JSON 형태로 되어있으며, terraform으로 구성된 인프라의 현재 상태를 보여줌

- **.terraform.tfstate.backup**

  - JSON 형태로 되어있으며, terraform으로 구성된 인프라를 백업하여 나중에 복구할 수 있도록 해줌

## 1.6 AWS 설정 구조

### (1) 계정 권한

| User            | Authority                                                        |
| --------------- | ---------------------------------------------------------------- |
| rlatkdReact     | AmazonS3FullAccess                                               |
| rlatkdFlask     | AmazonEC2FullAccess, AmazonS3FullAccess, AWSCodeDeployFullAccess |
| rlatkdMySQL     | AmazonEC2FullAccess, AmazonRDSFullAccess                         |
| rlatkdTerraform | AdministratorAccess                                              |

### (2) 키

| Service    | KeyPair       |
| ---------- | ------------- |
| Amazon EC2 | rlatkdKeyPair |

| Service               | AccessKey       |
| --------------------- | --------------- |
| Terraform             | rlatkdTerraform |
| GitHubActions - React | rlatkdReact     |
| GitHubActions - Flask | rlatkdFlask     |

### (3) 그룹 당 규칙

| InBound Rule | Security Group: rlatkdFlaskWebServserSg |
| ------------ | --------------------------------------- |
| Protocol     | TCP                                     |
| Port         | 5000                                    |
| Source       | 0.0.0.0/0                               |

| OutBound Rule | Security Group: rlatkd-ec2-rds-Sg |
| ------------- | --------------------------------- |
| Type          | MySQL/Aurora                      |
| Protocol      | TCP                               |
| Port          | 3306                              |
| Target        | rlatkd-rds-ec2-Sg                 |

| InBound Rule | Security Group: rlatkd-rds-ec2-Sg |
| ------------ | --------------------------------- |
| Type         | MySQL/Aurora                      |
| Protocol     | TCP                               |
| Port         | 3306                              |
| Source       | rlatkd-ec2-rds-Sg                 |

### (4) 역할

| Service               | Role                                              |
| --------------------- | ------------------------------------------------- |
| Amazon EC2            | rlatkdEC2AccessS3Role (rlatkdCodeDeployEC2Policy) |
| AWS CodeDeploy Group  | rlatkdCodeDeployRole                              |
| GitHubActions - Flask | AccessKey: rlatkdFlask AK                         |

# 2. Amazon Web Service

## 2.1 Frontend (Amazon S3)

### (1) 초기 설정

### (1-1) rlatkdReact 계정 생성 후 로그인

## <img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactUser.jpg">

### (2) Amazon S3 설정

### (2-1) Amazon S3 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket3.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/makeS3Bucket4.jpg">

### (2-2) 정적 웹 사이트 호스팅 활성화

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/staticWebHostingActivate1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/staticWebHostingActivate2.jpg">

### (2-3) 버킷과 객체에 퍼블릭 액세스 권한 부여

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addS3PublicAccessAutority3.jpg">

### (3) Amazon S3에 배포

### (3-1) React 앱 빌드

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

### (3-2) 빌드한 React 앱 소스 코드를 Amazon S3에 등록

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactCodeToBucket1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/addReactCodeToBucket2.jpg">

### (4) 서비스 정상 작동 확인

### (4-1) 브라우저로 Amazon S3의 웹 사이트 앤드포인트로 접근

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/bucketEndpoint.jpg">

## 2.2 Frontend (AWS CloudFront)

### (1) Amazon S3만으로 정적 웹을 호스팅으로 서비스할 때 문제점

- `https`가 아닌 `http` 통신을 해야 한다는 점
- Amazon S3이 퍼블릭 공개라는 점
- Amazon S3의 엔드포인트 주소를 그대로 사용해야 한다는 점
- 해결하기 위해선 AWS CloudFront를 이용

### (2) AWS CloudFront

### (2-1) AWS CloudFront란

- AWS Global Edge Server를 통해 CDN(Content Delivery Network) 역할을 해주는 AWS 서비스

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/OAI.jpg">

- OAI를 설정하면 Amazon S3에 퍼블릭으로 공개하지 않고도 AWS CloudFront를 통해서 Amazon S3에 퍼블릭으로 접근할 수 있음
- 동시에 AWS CloudFront를 우회하여 Amazon S3에 직접 액세스할 수 없음

### (2-2) Origin Shield

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/originShield1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/originShield2.jpg">

- AWS CloudFront에서 캐싱 계층을 하나 더 추가하여 사용자(클라이언트)와 엣지 서버간의 거리를 줄이는 기능
- 캐시 적중률을 높이고 오리진 서버의 부하를 줄여주어 로드 속도를 향상시키는 효과가 있음
- Origin Shield를 활성화하면 요청이 Origin Shield를 경유할 때마다 비용이 추가로 발생

### (3) 초기 설정

### (3-1) 초기 설정-1

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/settings1.jpg">

- 자동으로 객체 압축을 **Yes**로 설정 -> 요청할 리소스의 파일 크기를 비약적으로 줄여줄 수 있음
- 뷰어 프로토콜 정책는 **Redirect HTTP to HTTPS**로 설정 -> HTTP 프로토콜로 접속 시 자동으로 HTTPS로 리다이렉트됨
- 허용된 HTTP 방법은 **GET, HEAD**로 설정 -> 정적 리소스를 배포할 것이기 때문에 다른 HTTP Method를 허용하지 않아도 됨

### (3-2) 초기 설정-2

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/settings2.jpg">

- 캐시 키 및 원본 요청은 **CachingOptimized**를 선택 -> 대부분의 상황에서 적절한 캐시 정책을 바로 적용할 수 있음

### (3-3) 초기 설정-3

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/settings3.jpg">

- 보통 모든 엣지 로케이션에서 사용(최고의 성능)을 사용하면 되지만, 비용을 절약해야 하는 상황이거나 서비스 지역 타겟이 정해져 있을 때 적절한 항목을 선택하면 됨

### (3-4) 초기 설정-4

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/settings4.jpg">

- 기본값 루트 객체에 인덱스 페이지의 파일명을 입력
- `/`는 입력하면 안 됨

### (3-5) 초기 설정-5

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/settings5.jpg">

- React와 같은 SPA를 배포하는 상황이라면 Fallback Redirect 설정을 해주어야 함

## 2.3 Backend (Amazon EC2)

### (1) 초기 설정

### (1-1) rlatkdFlask 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/addFlaskUser.jpg">

### (1-2) VPC 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createVPC.jpg">

### (1-3) 보안 그룹 생성

`rlatkdFlaskWebServerSg`

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createSg.jpg">

### (2) Amazon EC2 설정

### (2-1) Public Subnet에 Amazon EC2를 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createEC2Instance3.jpg">

### (2-2) Amazon EC2의 Public IP 주소로 SSH 접속

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/accessSSH.jpg">

### (2-3) Apache HTTP Server 설치

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

### (2-4) PHP 설치

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

### (2-5) 웹 루트 디렉터리 삭제

```
ubuntu@ip-10-0-3-255:~$ cd /var/www/html/
ubuntu@ip-10-0-3-255:/var/www/html$ ls
index.html

ubuntu@ip-10-0-3-255:/var/www/html$ sudo rm -rf *
ubuntu@ip-10-0-3-255:/var/www/html$ ls
```

## 2.4 Database (Amazon RDS)

### (1) 초기 설정

### (1-1) rlatkdMySQL 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/addMySQLUser.jpg">

### (2) Amazon RDS 설정

### (2-1) Private Subnet에 Amazon RDS를 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS3.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS4.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createRDS5.jpg">

### (2-2) Amazon RDS에서 Amazon EC2(Flask)로의 연결 설정

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectEC2Instance3.jpg">

- Amazon EC2(Flask)는 Backend server를 포함하며 Bastion Host 역할을 함

### (2-3) Bastion Host

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/bastionHost.jpg">

- 배스천 호스트(Bation Host)는 내부 네트워크와 외부 네트워크 사이에 위치하는 게이트웨이

- 보안대책의 일환으로 사용되며, 내부 네트워크를 겨냥한 공격에 대해 방어하도록 설계됨

- 네트워크의 복잡도와 구성에 따라 다르지만, 단일 배스천 호스트 그 자체로서 방어를 할 수도 있으며, 또는 다른 방호 계층과 함께 대형 보안 시스템의 일부가 되기도 함

- 접근 제어 기능과 더불어 게이트웨이로서 가상 서버(Proxy Server)의 설치, 인증, 로그 등을 담당

- 그만큼 위험에 노출되는 경우가 많기 때문에, 배스천 호스트는 네트워크 보안상 가장 중요한 방화벽 호스트임

- 특히 내부 네트워크 전체의 보안을 담당하기 때문에 관리자의 감시 및 정기적인 점검이 뒷받침되어야 함

### (2-4) MySQL Workbench를 실행해서 RDS로의 연결 설정

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/connectWorkbench.jpg">

### (3) Database 설정

### (3-1) MySQL Workbench에서 schema 및 table 생성

```
CREATE SCHEMA IF NOT EXISTS `auction` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `auction` ;


-- -----------------------------------------------------
-- Table `auction`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`user` (
  `id` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `nickname` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `auction`.` history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `auction`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endTime` DATETIME NOT NULL,
  `startTime` DATETIME NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  `price` DOUBLE NOT NULL,
  `user_id` VARCHAR(50) NOT NULL,
  `image` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `auction`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `auction`.`prehistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `auction`.`prehistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `item_id` int NOT NULL,
  `endTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_prehistory_user1_idx` (`user_id`),
  KEY `fk_prehistory_item1_idx` (`item_id`),
  CONSTRAINT `fk_prehistory_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `fk_prehistory_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
)

ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE USER 'user1'@'%' IDENTIFIED BY '1234';
GRANT ALL ON auction.* TO 'user1'@'%';
```

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/database/createSchemaTable.jpg">

# 3. Terraform

## 3.1 Terraform 설정

### (1) 초기 설정-1

### (1-1) rlatkdTerraform 계정 생성 후 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/tfUser.jpg">

### (1-2) 액세스 키 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/tfAccessKey.jpg">

### (2) 초기 설정-2

### (2-1) AWS CLI에 로그인

```
.\terraform>aws configure

AWS Access Key ID [****************QNIN]: ****
AWS Secret Access Key [****************5d04]: ****
Default region name [ap-northeast-2]:
Default output format [json]:
```

### (2-2) AWS 명령어 작동 확인

```
.\terraform>aws s3 ls

2023-11-23 17:11:34 backfirststep-bucket
2023-11-24 10:15:45 cicd-bucket-jgwow
2023-11-22 20:39:35 firststep-bucket
2023-11-22 11:57:41 project3-shyun-bucket
2023-11-22 19:02:59 rlatkd-flask-bucket
2023-11-22 14:36:01 rlatkd-react-bucket
```

### (2-3) Terraform 설정 초기화

```
.\terraform>terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.26.0...
- Installed hashicorp/aws v5.26.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## 3.2 Terraform을 이용해 인프라 구성

### (1) `terraform apply`

```
C:\aws> terraform apply
aws_instance.example: Refreshing state... [id=i-060ecf5b27718c689]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.example must be replaced
-/+ resource "aws_instance" "rlatkdWebServer" {
      ~ arn                                  = "arn:aws:ec2:ap-northeast-2:561845507088:instance/i-086cae3329a3f7d75" -> (known after apply)
      ~ associate_public_ip_address          = true -> (known after apply)
...
...
      + user_data                            = "67e34b406ab639a606a64fe06965b26bf8036a9c" # forces replacement
      + user_data_base64                     = (known after apply)
      ~ user_data_replace_on_change          = false -> true
      ~ vpc_security_group_ids               = [
          - "sg-0380b404f6530ca72",
        ] -> (known after apply)
        # (5 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }
...
...
      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-037350e565483e3a9" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.rlatkdWebServer: Destroying... [id=i-086cae3329a3f7d75]
aws_instance.rlatkdWebServer: Still destroying... [id=i-086cae3329a3f7d75, 10s elapsed]
aws_instance.rlatkdWebServer: Still destroying... [id=i-086cae3329a3f7d75, 20s elapsed]
aws_instance.rlatkdWebServer: Destruction complete after 30s
aws_instance.rlatkdWebServer: Creating...
aws_instance.rlatkdWebServer: Still creating... [10s elapsed]
aws_instance.rlatkdWebServer: Still creating... [20s elapsed]
aws_instance.rlatkdWebServer: Creation complete after 22s [id=i-086cae3329a3f7d75]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```

## 3.3 자동으로 구성된 인프라

### (1) VPC 구성 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/vpc.jpg">

### (2) Amazon EC2 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/ec2.jpg">

### (3) Amazon S3확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/s3.jpg">

### (4) Amazon RDS 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/terraform/rds.jpg">

# 4. GitHub Actions & AWS CodeDeploy

## 4.1 Frontend

### (1) GitHub Actions

**React 앱은 Amazon EC2가 아닌 Amazon S3에 정적 상태로 저장하기 때문에 AWS CodeDeploy가 필요하지 않음**

### (1-1) Access Key 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/accessKey1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/accessKey2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/accessKey3.jpg">

### (1-2) GitHub Repository(DevOps-React)에 Secret을 추가

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/githubReposSecrets.jpg">

### (1-3) GitHub Actions를 이용해 자동화한 과정을 명시

**./.github/workflows/deploy.yml**

```
name: Deploy to Amazon S3 bucket

on:
  push:
    branches: [ "main" ]

env:
  AWS_REGION: ap-northeast-2
  S3_BUCKET_NAME: rlatkd-react-bucket
  CLOUDFRONT_NAME: E28M3K5TF5L3PV

permissions:
  contents: read
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Cache node modules
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

      - if: steps.npm-cache.outputs.cache-hit == 'true'
        run: echo 'npm cache hit!'
      - if: steps.npm-cache.outputs.cache-hit != 'true'
        run: echo 'npm cache missed!'

      - name: Install Dependencies
        if: steps.cache.outputs.cache-hit != 'true'
        run: npm install

      - name: Build
        run: npm run build

      - name: Remove template files
        run: rm -rf node_modules public src index.html package*

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: upload to S3
        run: aws s3 sync build/ s3://${{ env.S3_BUCKET_NAME }} --acl public-read
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

      - name: CloudFront delete cache
        uses: chetan/invalidate-cloudfront-action@v2
        env:
          DISTRIBUTION: ${{ env.CLOUDFRONT_NAME }}
          PATHS: "/*"
          AWS_REGION: ${{ env.AWS_REGION }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### (2) React test 코드를 삽입 후 GitHub에 commit 시 자동으로 배포

### (2-1) Header.js의 로그인/회원가입을 테스트/회원가입으로 변경

**./client/src/styles/Header.js**

```
...
...

          {
            isLogin  ? (<button onClick={handlerLogout}>로그아웃</button>) :
            (<button><Link to='/login'>테스트/회원가입</Link></button>)
          }
...
...
```

### (2-2) 배포 진행

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/deploy.jpg">

### (2-3) 배포 성공

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/deploySuccess.jpg">

### (2-4) 수정된 코드가 자동으로 배포되어 적용된 것을 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/client/commitedReact.jpg">

## 4.2 Backend

### (1) AWS CodeDeploy

### (1-1) rlatkdWebServer EC2에 적용할 정책 생성

**rlatkdCodeDeployEC2Policy**

```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
			    "s3:Get*",
			    "s3:List*"
			],
			"Resource": "*"
		}
	]
}
```

### (1-2) rlatkdWebServer EC2에 적용할 역할 생성 후 적용

**rlatkdEC2AccessS3Role**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployEC2role1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployEC2role2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployEC2role3.jpg">

### (1-3) AWS Code Deploy Agent 설치

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployAgent.jpg">

```
ubuntu@ip-10-0-3-255:/var/www/html$ sudo apt update
ubuntu@ip-10-0-3-255:/var/www/html$ sudo apt update
ubuntu@ip-10-0-3-255:/var/www/html$ sudo apt install ruby-full
ubuntu@ip-10-0-3-255:/var/www/html$ sudo apt install wget
ubuntu@ip-10-0-3-255:/var/www/html$ cd /home/ubuntu
ubuntu@ip-10-0-3-255:~$
ubuntu@ip-10-0-3-255:~$ wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
ubuntu@ip-10-0-3-255:~$ chmod +x ./install
ubuntu@ip-10-0-3-255:~$ sudo ./install auto
ubuntu@ip-10-0-3-255:~$ sudo service codedeploy-agent status

● codedeploy-agent.service - LSB: AWS CodeDeploy Host Agent
     Loaded: loaded (/etc/init.d/codedeploy-agent; generated)
     Active: active (running) since Wed 2023-11-22 09:48:20 UTC; 7s ago
       Docs: man:systemd-sysv-generator(8)
    Process: 22738 ExecStart=/etc/init.d/codedeploy-agent start (code=exited, status=0/SUCCESS)
      Tasks: 2 (limit: 1121)
     Memory: 57.4M
        CPU: 1.085s
     CGroup: /system.slice/codedeploy-agent.service
             ├─22744 "codedeploy-agent: master 22744" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" >
             └─22746 "codedeploy-agent: InstanceAgent::Plugins::CodeDeployPlugin::CommandPoller of >

Nov 22 09:48:20 ip-10-0-3-255 systemd[1]: Starting LSB: AWS CodeDeploy Host Agent...
Nov 22 09:48:20 ip-10-0-3-255 codedeploy-agent[22738]: Starting codedeploy-agent:
Nov 22 09:48:20 ip-10-0-3-255 systemd[1]: Started LSB: AWS CodeDeploy Host Agent.
```

### (1-4) 아래와 같이 나오면 정상 Agent가 정상 작동중임

```
...
...
     CGroup: /system.slice/codedeploy-agent.service
             ├─22744 "codedeploy-agent: master 22744" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" >
여기 확인 >>> └─22746 "codedeploy-agent: InstanceAgent::Plugins::CodeDeployPlugin::CommandPoller of >
...
...
```

### (1-5) AWS CodeDeploy에서 사용할 역할 생성

**rlatkdCodeDeployRole**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createCodeDeployGroupRole1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/createCodeDeployGroupRole2.jpg">

### (1-6) AWS CodeDeploy 애플리케이션과 배포 그룹을 생성

**애플리케이션**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployApp.jpg">

**배포 그룹**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployGroup1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployGroup2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/codedeployGroup3.jpg">

### (1-7) AWS CodeDeploy Agent가 앱을 가져올 Amazon S3 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/flaskS3Bucket.jpg">

### (1-8) AWS CodeDeploy를 이용해 자동화한 과정을 명시

**./appspec.yml**

```
version: 0.0
os: linux
files:
  - source: /
    destination: /home/ubuntu/ssgbay

hooks:
  BeforeInstall:
    - location: scripts/beforeInstall.sh
      runas: root
  AfterInstall:
    - location: scripts/afterInstall.sh
      runas: root
    - location: scripts/runServer.sh
      runas: ubuntu
```

### (1-9) appspec.yml에 사용할 shell scripts

**./scripts/beforeInstall.sh**

```
#!/bin/bash

var=$(ps -ef | grep 'python3 -u app.py' | grep -v 'grep')
pid=$(echo ${var} | cut -d " " -f2)
if [ -n "${pid}" ]
then
   kill -9 ${pid}
   echo ${pid} is terminated.
else
   echo ${pid} is not running.
fi

rm -rf /home/ubuntu/ssgbay
mkdir  /home/ubuntu/ssgbay
```

**./scripts/afterInstall.sh**

```
#!/bin/bash

cd      /home/ubuntu/ssgbay

echo    ">>> make static directory for upload images -----------------------"
mkdir   resources

echo    ">>> pip install ---------------------------------------------------"
pip     install -r requirements.txt

echo    ">>> cron settings -------------------------------------------------"
crontab -l | { cat; echo "* * * * * /usr/bin/python3 /home/ubuntu/ssgbay/historyUpdate.py >> /var/log/cron.log 2>&1"; } | crontab -

echo     ">>> npm install --------------------------------------------------"
npm     install
npm     run build

echo    ">>> remove template files -----------------------------------------"
rm      -rf  appspec.yml requirements.txt

echo    ">>> change owner to ubuntu ----------------------------------------"
chown   -R ubuntu /home/ubuntu/ssgbay
```

**./scripts/runServer.sh**

```
#!/bin/bash

cd      /home/ubuntu/ssgbay

echo    ">>> run app -------------------------------------------------------"

cron

python3 -u app.py > /dev/null 2> /dev/null < /dev/null &

```

### (2) GitHub Actions

### (2-1) Access Key 생성

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/accessKey1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/accessKey2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/accessKey3.jpg">

### (2-2) GitHub Repository(DevOps-Flask)에 Secret을 추가

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/githubReposSecrets.jpg">

### (2-3) GitHub Actions를 이용해 자동화한 과정을 명시

**./.github/workflows/deploy.yml**

```
name: Deploy to Amazon EC2

on:
  push:
    branches: [ "main" ]

env:
  AWS_REGION: ap-northeast-2
  S3_BUCKET_NAME: rlatkd-flask-bucket
  CODE_DEPLOY_APPLICATION_NAME: rlatkdFlaskApp
  CODE_DEPLOY_DEPLOY_GROUP_NAME: rlatkdFlaskDeployGroup

permissions:
  contents: read

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    environment: production
    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ${{ env.AWS_REGION }}

    - name: Upload to AWS S3
      run: |
        aws deploy push \
          --application-name ${{ env.CODE_DEPLOY_APPLICATION_NAME }} \
          --s3-location s3://$S3_BUCKET_NAME/$GITHUB_SHA.zip \
          --ignore-hidden-files \
          --source .

    - name: Deploy to AWS EC2 from S3
      run: |
        aws deploy create-deployment \
          --application-name ${{ env.CODE_DEPLOY_APPLICATION_NAME }} \
          --deployment-config-name CodeDeployDefault.AllAtOnce \
          --deployment-group-name ${{ env.CODE_DEPLOY_DEPLOY_GROUP_NAME }} \
          --s3-location bucket=$S3_BUCKET_NAME,key=$GITHUB_SHA.zip,bundleType=zip
```

### (3) Flask test 코드를 삽입 후 GitHub에 commit 시 자동으로 배포

### (3-1) 배포 진행

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/deploy.jpg">

### (3-2) 배포 성공

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/deploySuccess1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/deploySuccess2.jpg">

### (3-3) 수정된 코드가 자동으로 배포되어 적용된 것을 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/commitedFlask.jpg">

# 5. Trouble Shooting

## 5.1 Frontend

### (1) autoprefixer

```
Warning
(11:5) autoprefixer: start value has mixed support, consider using flex-start instead
```

> **./src/styles/MainPage.module.css**
>
> ```
> ...
> ...
> .cardContainer {
> display: flex;
> flex-wrap: wrap;
> justify-content: start;
> max-width: 1024px;
> min-width: 1024px;
> gap: 70px;
> }
> ...
> ...
> ```
>
> - Webpack 구성 파일의 모듈 규칙 안에서 로더를 설정하여 작동하는데, justify-content 항목은 start 보다 `flex-start`로 하는게 더 호환성이 좋다고 추천
>
> ```
> ...
> ...
> .cardContainer {
> display: flex;
> flex-wrap: wrap;
> justify-content: flex-start;
> max-width: 1024px;
> min-width: 1024px;
> gap: 70px;
> }
> ...
> ...
> ```
>
> ---
>
> **./package.json**
>
> - 일일히 `start`에서 `flex-start`로 변경하는 방법도 있지만 무시하고 진행하려면 `sourceMap`의 설정 값을 `true`로 하는 방법도 있음
>
> ```
> ...
> ...
> {
> loader: "sass-loader",
> options: {
> sourceMap: true,
> },
> },
> ...
> ...
> ```

### (2) eslint: `<img> alt`

```
Line 160:15:  Redundant alt attribute. Screen-readers already announce `img` tags as an image. You don’t need to use the words `image`, `photo,` or `picture` (or any specified custom words) in the alt prop  jsx-a11y/img-redundant-alt
```

> **.src/pages/CreatePage.js**
>
> ```
> ...
> ...
> {imagePreview && (<img className={styles.previewImage} src={imagePreview} alt="Selected Image" />)}
> ...
> ...
> ```
>
> - 이미 <image> 태그에서 이미지라는 것을 알았으니 alt 속성에서 image, photo, picture 이라는 단어를 다시 사용할 필요가 없다고 추천
>
> ```
> ...
> ...
> {imagePreview && (<img className={styles.previewImage}
> src={imagePreview} alt="Selected" />)}
> ...
> ...
> ```

### (3) eslint: `eqeqeq`

```
...
...
Line 34:22:  Expected '===' and instead saw '=='                   eqeqeq
Line 38:20:  Expected '===' and instead saw '=='                   eqeqeq
...
...
```

> **.src/pagess/DetailPage.js**
>
> ```
> ...
> ...
> if (purchaseId == '') {
>     alert('로그인 후 입찰 가능합니다. ');
>     return;
> }
> ...
> ...
> ```
>
> - 이중 등호`==` 보단 삼중 등호`===`을 사용하는 것을 추천
>   | 비교 종류 | 추상적 같음 비교 | 엄격한 같음 비교 |
>   | ------|----------------- | ------------------------------------- |
>   | 해당하는 기호 | 이중 등호, 동등 연산자 | 삼중 등호, 일치 연산자 |
>   | 비교 방식 | 자동으로 형변환하여 같음을 비교함 | 형변환을 수해하지 않고 비교함 |
>
> ```
> ...
> ...
> if (purchaseId === '') {
>     alert('로그인 후 입찰 가능합니다. ');
>     return;
> }
> ...
> ...
>
> ```

## 5.2 Backend

### (1) 배포했으나 연결할 수 없음

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/cannotAccess.jpg">

### (1-1) deployment-archive 에서 확인하면 파일들이 제대로 있음

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-VTU4ZNI12/deployment-archive$ ls

app.py       crontabFile  historyUpdate.py  package-lock.json  requirements.txt  scripts
appspec.yml  database.py  node_modules      package.json       resources
```

### (1-2) 그러나 pip가 인스턴스 내부에 안 깔려있음

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3L7DPAI12/deployment-archive$ python app.py
Command 'python' not found, did you mean:
  command 'python3' from deb python3
  command 'python' from deb python-is-python3

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3L7DPAI12/deployment-archive$ python3 app.py
Traceback (most recent call last):
  File "/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3L7DPAI12/deployment-archive/app.py", line 1, in <module>
    from flask import Flask, request, jsonify
ModuleNotFoundError: No module named 'flask'
```

```
c55d7/d-VTU4ZNI12/deployment-archive$ pip --version

Command 'pip' not found, but can be installed with:
sudo apt install python3-pip
```

### (2) 해결 방법

### (2-1) pip를 다운로드

```
ubuntu@ip-10-0-3-255:/$ sudo apt-get install python3-pip
ubuntu@ip-10-0-3-255:/$ pip --version
pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)
```

### (2-2) python3 app.py로 테스트

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-VTU4ZNI12/deployment-archive$ python3 app.py

Traceback (most recent call last):
  File "/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-VTU4ZNI12/deployment-archive/app.py", line 5, in <module>
    from flask_jwt_extended import JWTManager
  File "/usr/local/lib/python3.10/dist-packages/flask_jwt_extended/__init__.py", line 1, in <module>
    from .jwt_manager import JWTManager as JWTManager
  File "/usr/local/lib/python3.10/dist-packages/flask_jwt_extended/jwt_manager.py", line 8, in <module>
    from jwt import DecodeError
ImportError: cannot import name 'DecodeError' from 'jwt' (/usr/local/lib/python3.10/dist-packages/jwt/__init__.py)
```

### (2-3) jwt가 문제인거같아 pip install jwt

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-VTU4ZNI12/deployment-archive$ pip install jwt

Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: jwt in /usr/local/lib/python3.10/dist-packages (1.3.1)
Requirement already satisfied: cryptography!=3.4.0,>=3.1 in /usr/local/lib/python3.10/dist-packages (from jwt) (41.0.5)
Requirement already satisfied: cffi>=1.12 in /usr/local/lib/python3.10/dist-packages (from cryptography!=3.4.0,>=3.1->jwt) (1.16.0)
Requirement already satisfied: pycparser in /usr/local/lib/python3.10/dist-packages (from cffi>=1.12->cryptography!=3.4.0,>=3.1->jwt) (2.21)
```

---

### (2-4) PyJWT에 문제가 있는것을 발견

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-VTU4ZNI12/deployment-archive$ pip list
...
...
PyGObject 3.42.1
PyHamcrest 2.0.2
PyJWT 2.8.0
PyMySQL 1.1.0
pyOpenSSL 21.0.0
...
...

```

### (2-5) PyJWT 버전 변경

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-G5SGOXI12/deployment-archive$ sudo pip install PyJWT==v1.7.1

```

### (3) 정상 작동 확인

```
ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-G5SGOXI12/deployment-archive$ python3 app.py

- Serving Flask app 'app'
- Debug mode: off
  WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
- Running on all addresses (0.0.0.0)
- Running on http://127.0.0.1:5000
- Running on http://10.0.3.255:5000
  Press CTRL+C to quit
```

## 5.3 Backend - Database

### (1) Backend와 Database 연동이 안 됨

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/internalServerError.jpg">

### (1-1) Amazon EC2(Flask) 내부에서 접속

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/ec2rdsrule.jpg">

```
ubuntu@ip-10-0-3-255:~$ sudo apt-get update
ubuntu@ip-10-0-3-255:~$ sudo apt-get install mysql-client
ubuntu@ip-10-0-3-255:~$ sudo mysql -h database-1.cyu7qnoubf3u.ap-northeast-2.rds.amazonaws.com -u rlatkdMySQL -p
Enter password:
```

```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 33
Server version: 8.0.33 Source distribution

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 33
Server version: 8.0.33 Source distribution

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

```
mysql> show databases;

+--------------------+
| Database           |
+--------------------+
| auction            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

### (1-2) dummy data를 넣은 후 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/dummyData.jpg">

### (1-3) Amazon EC2(Flask)에서도 정상으로 작동하는 것을 확인

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| auction            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> use auction;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_auction |
+-------------------+
| history           |
| item              |
| prehistory        |
| user              |
+-------------------+
4 rows in set (0.00 sec)

mysql> select * from history
    -> ;
+----+---------+---------+
| id | user_id | item_id |
+----+---------+---------+
| 11 | 11      |      11 |
+----+---------+---------+
1 row in set (0.00 sec)
```

### (1-4) 그래도 연결이 안됨

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/internalServerError.jpg">

### (2) 해결 방법

### (2-1) database.py historyupdate.py 의 dbconnection을 수정

```
...
...
connectionString = {
    'host': 'database-1.cyu7qnoubf3u.ap-northeast-2.rds.amazonaws.com',
    'port': 3306,
    'database': 'auction',
    'user': 'rlatkdMySQL',
    'password': '****',
    'charset': 'utf8',
    'cursorclass': pymysql.cursors.DictCursor
}
...
...
```

### (3) 재 배포 시 정상으로 작동하는 것을 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/reDeployJSON.jpg">

## 5.4 Frontend - Backend

### (1) Frontend와 Backend 연동이 안 됨

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/disconnectFrontend1.jpg">

```
Mixed Content: The page at 'https://d3u6h8k7brrkx6.cloudfront.net/'    xhr. js:256 was loaded over HTTPS, but requested an insecure XMLHttpRequest endpoint 'http://43.202.66.215:5000/?sor=date&keyword='.
This request has been blocked; the content must be served over HTTPS.
```

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/disconnectFrontend2.jpg">

### (2) 해결 방법

### (2-1) https로 접속하여 오류가 난 것

### (2-2) 접속 후 다시 확인

### (3) 정상 작동 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/server/connectedFrontend.jpg">

### (4) SSL 인증-1

### (4-1) 모든 SSL 관련 작업을 처리하기 위해 Flask Amazon EC2에 Nginx를 추가 (현재는 Apache)

```
$ sudo apt install nginx
$ sudo service nginx start
```

### (4-2) Certbot 설치 (Ubuntu ^20 부터는 동작하지 않음)

```
$ wget https://dl.eff.org/certbot-auto
```

### (4-3) Ubuntu ^20인 경우: Snapd를 이용하여 Certbot 설치

```
$ sudo snap install core
$ sudo snap refresh core
$ sudo apt remove certbot
$ sudo snap install --classic certbot
$ ln -s /snap/bin/certbot /usr/bin/certbot
```

### (4-4) certbot을 이용해 ssl 인증서를 받아온 뒤 Certbot이 스스로 Nginx 설정을 해주도록 함

```
$ sudo certbot --nginx
```

```
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Your existing certificate has been successfully renewed, and the new certificate
has been installed.

The new certificate covers the following domains: AWS CLOUDFRONT ENDPOINT # https가 설정된 도메인
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Subscribe to the EFF mailing list (email: woorimprog@gmail.com).

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/idu-market.shop/fullchain.pem    # 공개키 경로
   Your key file has been saved at:
   /etc/letsencrypt/live/idu-market.shop/privkey.pem    # 비밀키 경로
   Your certificate will expire on 2021-08-15. To obtain a new or
   tweaked version of this certificate in the future, simply run
   certbot again with the "certonly" option. To non-interactively
   renew *all* of your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

### (4-5) 설정 상태

```
# 443 포트로 접근시 ssl을 적용한 뒤 3000포트로 요청을 전달해주도록 하는 설정.
server {
        server_name SSGBAY;

        location / {
                proxy_pass AWS CLOUDFRONT ENDPOINT;
        }

        listen 443 ssl; # managed by Certbot
        ssl_certificate /etc/letsencrypt/live/SSGBAY/fullchain.pem; # managed by Cert>
        ssl_certificate_key /etc/letsencrypt/live/SSGBAY/privkey.pem; # managed by Cert>

        include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

# 80 포트로 접근시 443 포트로 리다이렉트 시켜주는 설정
server {
        if ($host = SSGBAY) {
                return 301 https://$host$request_uri;
        } # managed by Certbot


        listen 80;
        server_name SSGBAY;
        return 404; # managed by Certbot
}
```

- certbot을 이용하여 ssl인증서를 발급할 경우 3개월 마다 갱신을 해줘야 함 - `$ certbot renew`

- 인증서의 유효기간이 끝나가면 본인이 certbot을 통해 ssl인증서를 받아올 때 입력해 준 이메일로 알림이 옴

- 3개월 마다 자동 갱신을 하도록 해줄 수도 있음 - crontab 이용

```
$ [cron 형식] /usr/bin/certbot renew --renew-hook="sudo systemctl restart apache2"
```

### (5) SSL 인증-2

### (5-1) Caddy config 생성

```
sudo vi /etc/systemd/system/caddy.service
```

```
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

### (5-2) Caddyfile 생성

```
sudo vi /etc/caddy/Caddyfile

```

```
{
admin 0.0.0.0:2020
}
<EC2의 퍼블릭 IPv4 주소>.nip.io {
reverse_proxy localhost:8080 # 들어오는 요청을 8080포트로 포워딩
}

# 예시 :

10.100.100.100.nip.io {
reverse_proxy localhost:8080
}

```

### (5-3) Caddy 동작 확인

```
sudo systemctl daemon-reload
sudo systemctl enable --now caddy
sudo systemctl status -l caddy

```

```
$ sudo systemctl status caddy.service

● caddy.service - Caddy
Loaded: loaded (/etc/systemd/system/caddy.service; enabled; vendor preset: disabled)
Active: active (running) since 화 2023-04-11 13:27:50 UTC; 5s ago
Docs: https://caddyserver.com/docs/
Main PID: 11243 (caddy)
CGroup: /system.slice/caddy.service
└─11243 /usr/bin/caddy run --environ --config /etc/caddy/Caddyfile

```

### (5-4) 설정 상태

```

2023/11/25 13:56:33.748 INFO using adjacent Caddyfile
2023/11/25 13:56:33.749 WARN Caddyfile input is not formatted; run the 'caddy fmt' command to fix inconsistencies {"adapter": "caddyfile", "file": "Caddyfile", "line": 2}
2023/11/25 13:56:33.749 INFO admin admin endpoint started {"address": "0.0.0.0:2020", "enforce_origin": false, "origins": ["//0.0.0.0:2020"]}
2023/11/25 13:56:33.750 WARN admin admin endpoint on open interface; host checking disabled {"address": "0.0.0.0:2020"}
2023/11/25 13:56:33.750 INFO http server is listening only on the HTTPS port but has no TLS connection policies; adding one to enable TLS {"server_name": "srv0", "https_port": 443}
2023/11/25 13:56:33.750 INFO http enabling automatic HTTP->HTTPS redirects {"server_name": "srv0"}
2023/11/25 13:56:33.751 INFO http enabling HTTP/3 listener {"addr": ":443"}
2023/11/25 13:56:33.751 INFO failed to sufficiently increase receive buffer size (was: 208 kiB, wanted: 2048 kiB, got: 416 kiB). See https://github.com/quic-go/quic-go/wiki/UDP-Receive-Buffer-Size for details.
2023/11/25 13:56:33.751 INFO http.log server running {"name": "srv0", "protocols": ["h1", "h2", "h3"]}
2023/11/25 13:56:33.751 INFO http.log server running {"name": "remaining_auto_https_redirects", "protocols": ["h1", "h2", "h3"]}
2023/11/25 13:56:33.752 INFO http enabling automatic TLS certificate management {"domains": ["10.100.100.100.nip.io"]}
2023/11/25 13:56:33.752 INFO autosaved config (load with --resume flag) {"file": "/root/.config/caddy/autosave.json"}
2023/11/25 13:56:33.752 INFO serving initial configuration
2023/11/25 13:56:33.753 INFO tls cleaning storage unit {"description": "FileStorage:/root/.local/share/caddy"}
2023/11/25 13:56:33.754 INFO tls finished cleaning storage units
2023/11/25 13:56:33.754 INFO tls.cache.maintenance started background certificate maintenance {"cache": "0xc000335490"}
Successfully started Caddy (pid=23624) - Caddy is running in the background

```

## 5.5 시연

### (1) 이미지 업로드가 안 됨

### (1-1) 현재 아무런 데이터도 없음

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/emptyDatas1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/emptyDatas2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/emptyDatas3.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/emptyDatas4.jpg">

### (1-2) 임의의 아이디와 비밀번호로 로그인 시도

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/randUser.jpg">

### (1-3) 테스트용 임의의 계정을 생성하여 로그인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/testUser.jpg">

### (1-4) 데이터베이스에 추가된 것을 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/testUserDb.jpg">

### (1-5) 토근 정상 발급 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/token1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/token2.jpg">

### (1-6) 로그인 상태에서 경매 물품 등록 글쓰기

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/createBoard1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/createBoard2.jpg">

- POST요청을 했는데 500 internal server Error가 발생 → 백엔드 문제인거 같음

### (2) 직접 Amazon EC2 내부로 들어가서 작업

### (2-1) Amazon EC2 내부로 들어가서 확인

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3XWE5BBQE/deployment-archive$ ps -ef | grep python3

root 398 1 0 Nov22 ? 00:00:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
root 567 1 0 Nov22 ? 00:00:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
ubuntu 38514 1 0 23:12 ? 00:00:00 python3 -u app.py
ubuntu 38537 38323 0 23:14 pts/0 00:00:00 grep --color=auto python3

```

- Flask 서버는 현재 잘 작동되고 있음 (당연히 다른 서비스가 잘 동작하니 서버에 문제가 생긴 건 아님)

### (3) 백그라운드로 실행시키고 있는 Flask를 종료 후 포그라운드로 실행한 다음 요청 및 응답을 확인

### (3-1) 서비스 중인 Flask App 종료

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3XWE5BBQE/deployment-archive$ kill -9 38514

```

### (3-2) 종료된지 확인

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3XWE5BBQE/deployment-archive$ ps -ef | grep python3

root 398 1 0 Nov22 ? 00:00:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
root 567 1 0 Nov22 ? 00:00:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
ubuntu 38547 38323 0 23:15 pts/0 00:00:00 grep --color=auto python3

```

- 정상적으로 종료됨

### (3-3) 다시 포그라운드로 실행

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3XWE5BBQE/deployment-archive$ python3 app.py

- Serving Flask app 'app'
- Debug mode: off
  WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
- Running on all addresses (0.0.0.0)
- Running on http://127.0.0.1:5000
- Running on http://10.0.3.255:5000
  Press CTRL+C to quit

```

### (3-4) 재시도

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/retry.jpg">

### (3-5) 파일이나 디렉터리를 찾을 수 없음

```

121.166.242.167 - - [23/Nov/2023 23:16:45] "GET /?sort=date&keyword= HTTP/1.1" 200 -
[Errno 2] No such file or directory: './resources/우영미1.JPEG'
121.166.242.167 - - [23/Nov/2023 23:17:14] "POST /create HTTP/1.1" 500 -

```

### (3-6) server 전체 구성 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/server.jpg">

### (3-7) resources라는 정적 디렉터리에 이미지 파일을 저장하는 형식

```

...
...
app = Flask(**name**, static_folder='./resources/')
UPLOAD_FOLDER = path.join('.', 'resources/')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
...
...
@app.route('/create', methods=['POST'])
def create():
try:
file = request.files['itemImage']
filename = file.filename
itemName = request.form.get('itemName')
itemContent = request.form.get('itemContent')
itemPrice = request.form.get('itemPrice')
itemImage = filename
userId = request.form.get('userId')
endTime = request.form.get('endTime')
file.save(os.path.join(app.config['UPLOAD_FOLDER'], file.filename))
image_url = 'http://43.202.66.215:5000/resources/' + file.filename
print(image_url)
return database.addItemInfo( itemName, itemContent, itemPrice, image_url, endTime, userId)

    except Exception as e:
        print(e)
        return jsonify({"message": "요청중 에러가 발생"}), 500, {'Content-Type': 'application/json'}

...
...

```

### (3-8) 근데 배포한 code deploy agent에 resources라는 디렉터리가 없음

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-3XWE5BBQE/deployment-archive$ ls

app.py crontabFile historyUpdate.py package-lock.json requirements.txt
appspec.yml database.py node_modules package.json scripts

```

### (4) 디렉터리가 존재하지 않는 이유

### (4-1) 테스트용 빈 디렉터리(testDir)를 하나 더 만들어서 실험

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/testDir.jpg">

### (4-2) GitHub commit을 하면 빈 디렉터리는 commit되지 않음

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/commitedGitHub1.jpg">

### (4-3) `touch` 명령어를 이용하여 크기가 0인 파일 생성

```

(venv) C:\Users\User\Desktop\project123\server\resources>touch .placeholder

```

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/commitedGitHub2.jpg">

- 정상적으로 commit됨

### (4-4) 그러나 여전히 다시 배포한 code deploy agent에 resources라는 디렉터리가 없음

```

ubuntu@ip-10-0-3-255:/opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/d-BCL59RJ22/deployment-archive$ ls

app.py crontabFile historyUpdate.py package-lock.json requirements.txt
appspec.yml database.py node_modules package.json scripts

```

### (5) AWS CodeDeploy를 잘못 이해하고 있었음

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/awsCodeDeploy.jpg">

- AWS CodeDeploy는 Amazon S3에서 빌드 산출물을 압축 파일로 가져와서 배포해줌
- AWS CodeDeploy에는 빌드 기능이 없기 때문에 별도의 빌드 과정이 필요함
- AWS CodeDeploy가 시행되기 위해선 Amazon EC2의 CodeDeploy Agent가 반드시 실행중이어야함

```

ubuntu@ip-10-0-3-255:$ sudo service codedeploy-agent status

● codedeploy-agent.service - LSB: AWS CodeDeploy Host Agent
Loaded: loaded (/etc/init.d/codedeploy-agent; generated)
Active: active (running) since Wed 2023-11-22 10:32:17 UTC; 1 day 14h ago
Docs: man:systemd-sysv-generator(8)
Tasks: 4 (limit: 1121)
Memory: 91.5M
CPU: 29.000s
CGroup: /system.slice/codedeploy-agent.service
├─22869 "codedeploy-agent: master 22869" "" "" "" "" "" "" "" "" "" "" "" "">
└─22871 "codedeploy-agent: InstanceAgent::Plugins::CodeDeployPlugin::Command>

```

- 실제 Flask App 서비스가 작동하고 있는 WorkDirectory는 `.server/scripts/runServer.sh`에 명시된 대로 `./home/ubuntu/ssgbay` 였음

**./server/scrpts/runServer.sh**

```

#!/bin/bash

cd /home/ubuntu/ssgbay

echo ">>> run app -------------------------------------------------------"

cron
python3 -u app.py > /dev/null 2> /dev/null < /dev/null &

```

- `./opt/codedeploy-agent/deployment-root/2a2e556f-917b-4615-a1ff-97a1ce4c55d7/${DEPLOY_LATEST_DIRECTORY}/deployment-archive` 는 Amazon S3에서 zip파일을 가져올 tmp 디렉터리였음

### (6) 해결 방법

### (6-1) 서비스가 작동하고 있는 디렉터리에 resources 디렉터리를 만들어 static folder 경로로 사용하면 됨

**./server/scripts/afterInstall.sh**

```

#!/bin/bash

cd /home/ubuntu/ssgbay

echo ">>> make static directory for upload images -----------------------"
mkdir resources
...
...

```

### (6-2) 정상적으로 폴더가 만들어진 것을 확인

```

ubuntu@ip-10-0-3-255:~/ssgbay$ ls

**pycache** crontabFile historyUpdate.py package-lock.json resources
app.py database.py node_modules package.json scripts

```

### (7) 재 배포 시 정상적으로 작동하는 것을 확인

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/normal1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/normal2.jpg">

## 5.6 Crontab

### (1) Crontab 작동이 안함

**Crontab**: 정해 놓은 일정 시각이 되면 설정해둔 작업을 실행

- 경매글 쓰기에서 경매 만료 시간을 설정
- 다른 유저가 해당 상품을 입찰
- 경매 만료 시간까지 자신의 입찰가가 최고가이면 구매 확정이 되어 해당 상품의 입찰 내역을 구매내역에서 볼 수 있음

**./server/scripts/afterInstall.sh**

```

#!/bin/bash

cd /home/ubuntu/ssgbay

echo ">>> make static directory for upload images -----------------------"
mkdir resources

echo ">>> pip install ---------------------------------------------------"
pip install -r requirements.txt

echo ">>> npm install --------------------------------------------------"
npm install
npm run build

echo ">>> remove template files -----------------------------------------"
rm -rf appspec.yml requirements.txt

echo ">>> change owner to ubuntu ----------------------------------------"
chown -R ubuntu /home/ubuntu/ssgbay

```

- 당연히 Crontab 관련 명시를 안 했으니 동작이 할리가 없음

### (2) 해결 방법

### (2-1) 다음의 내용들을 추가

**./server/scripts/afterInstall.sh**

```

#!/bin/bash

...
...
echo ">>> cron settings -------------------------------------------------"
crontab -l | { cat; echo "\* \* \* \* \* /usr/bin/python3 /home/ubuntu/ssgbay/historyUpdate.py >> /var/log/cron.log 2>&1"; } | crontab -
...
...

```

**./server/scripts/runServer.sh**

```

#!/bin/bash

cd /home/ubuntu/ssgbay

echo ">>> run app -------------------------------------------------------"

cron

python3 -u app.py > /dev/null 2> /dev/null < /dev/null &

```

### (3) 재 배포 시 정상적으로 작동하는 것을 확인

### (3-1) test1 user가 등록한 우영미 반팔1을 test2 user가 입찰

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/buyTshirt1.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/buyTshirt2.jpg">

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/buyTshirt3.jpg">

### (3-2) 작동 확인

**2023-11-24 am10:30 전**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/preHistory1.jpg">

**2023-11-24 am10:30 후**

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/preHistory2.jpg">

## 5.7 배포 시간 단축

### (1) deploy.yml 템플릿 수정

```
...
...
      - name: Cache node modules    ⇐ 캐시 액션 설치 및 설정 → 배포 시간 단축
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

      - if: steps.npm-cache.outputs.cache-hit == 'true'    ⇐ 캐싱 여부를 출력
        run: echo 'npm cache hit!'
      - if: steps.npm-cache.outputs.cache-hit != 'true'
        run: echo 'npm cache missed!'

      - name: Install Dependencies    ⇐ 캐시가 없거나 다른 경우에만 모듈 설치 → 배포 시간 단축
        if: steps.cache.outputs.cache-hit != 'true'
        run: npm install

      - name: Build
        run: npm run build

      - name: Remove template files    ⇐ 실행과 관련 없는 파일/디렉터리 삭제 → 배포 시간 단축
        run: rm -rf node_modules public src index.html package*
...
...
      - name: CloudFront delete cache    ⇐ 캐시 무력화 설정 → 배포 시간 단축
        uses: chetan/invalidate-cloudfront-action@v2
        env:
          DISTRIBUTION: ${{ env.CLOUDFRONT_NAME }}
          PATHS: "/*"
          AWS_REGION: ${{ env.AWS_REGION }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### (2) 캐시 설정 전

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/beforeCache.jpg">

### (3) 캐시 설정 후

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/afterCache1.jpg">

### (3-1) Amazon S3로 전송한 파일에 불필요한 파일 포함 여부

<img src="https://github.com/rlatkd/DevOps/blob/main/assets/preview/afterCache2.jpg">

# 6. 후기

- 기본적인 3계층 구조를 퍼블릭 클라우드로 배포해서 Docker & Kubernetes와는 색다르게 재밌었습니다.

- 또한 시연을 한 번에 성공한 것이 아닌 실패를 반복하며 구조들의 유기적인 흐름을 이해하는데 도움이 되었습니다.

- 그 중 가장 중요하다고 생각하는 보안과 연관된 설정(ex. 그룹, 액세스, 정책, 권한 등)들을 많이 배웠고 이렇게 실습 형식이 아닌, 실무에서 적용할 수 있도록 더 공부해야 할 것 같습니다.

- 모르는 것을 찾아볼 때 기존엔 구글링을 열심히 했지만 이번 기회 덕에 공식 문서를 자주 찾아봤고, 이를 통해 공식 문서에서 먼저 찾아보는 습관을 들였습니다.

- 프로젝트를 일찍 완료하고 다른 사람들과 공유하고 도와주며, 저와는 다른 환경에서의 배포에 대해 Trouble Shooting을 같이 하며 많은 시간을 할애했습니다.

- 이를 통해 정말 다양한 환경에서의 배포 과정에 대해 학습했으며, 일찍 완료했지만 다른 서비스들(ex. LB+ASG, EKS, GA를 이용한 Docker Image 생성, Lambda 등)을 시도하지 못 해 아쉽습니다.

- 그래도 다음 최종 프로젝트는 약 2달 간의 기간이 있기때문에 이번 기회에 기본기를 확실히 다져놓은 것 같아 기대가 됩니다.

- Terraform을 이용해 코드로 내가 구상한 인프라가 자동으로 생성되는 것이 너무 신기하고 재밌었으며, GitHub Actions와 AWS CodeDeploy를 통해 배포 자동화를 함으로써 안 그래도 재밌는 공부 더욱더 재밌어졌습니다.

- 하루하루 지날 때마다 성장하고 있음을 느끼며 제 목표에 다다르는데 이제 시작이고, 앞으로의 내일들이 너무 기대가 됩니다.

- 박창렴 강사님을 만난 건 제 인생 최고의 행운이었던 것 같습니다. 감사합니다.
