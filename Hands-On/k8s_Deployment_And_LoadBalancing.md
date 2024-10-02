# 🔮Kubernetes 환경에서 다중 인스턴스를 배포하여 로드밸런싱하기

## 📌실습 내용

- Spring Boot 애플리케이션의 Jar 파일을 Docker 이미지로 생성하고, Kubernetes 환경에서 배포 및 로드밸런싱 실습
- Minikube를 활용해 Kubernetes 클러스터를 설정하고, 애플리케이션을 로드밸런서 서비스로 배포

## 💡실습 목표

- Spring Boot 애플리케이션을 Docker 컨테이너 이미지로 생성하는 방법 복습
- Docker 이미지를 Kubernetes 클러스터에 배포하고, 트래픽을 분산 처리하는 방법을 이해
- Minikube를 활용해 로컬 Kubernetes 환경에서 애플리케이션을 운영하는 기본 절차 익히기

## 🧾실습 과정

### 1️⃣ Dockerfile 작성

- JAR 파일을 Docker 이미지로 빌드하기 위한 `Dockerfile`을 작성

  ```dockerfile
  FROM openjdk:17-jdk-alpine
  WORKDIR /app
  COPY SpringApp-0.0.1-SNAPSHOT.jar app.jar
  EXPOSE 8999
  ENTRYPOINT ["java", "-jar", "springapp.jar"]
  ```

- Dockerfile이 있는 디렉토리에서 다음 명령어로 이미지를 생성

  ```bash
  docker build -t springapp:1.0 .
  ```

### 2️⃣ Minikube 클러스터 시작

- 로컬 Kubernetes 클러스터를 Minikube로 시작

  ```bash
  minikube start
  ```

### 3️⃣ Docker 이미지를 Minikube에서 사용

- Minikube에서 로컬에서 빌드한 Docker 이미지를 사용하기 위해 환경을 설정

  ```bash
  eval $(minikube -p minikube docker-env)
  ```

### 4️⃣ SpringBoot 애플리케이션 배포

- `kubectl`을 사용하여 3개의 리플리카를 가진 SpringBoot 애플리케이션을 배포

  ```bash
  kubectl create deployment springapp --image=springapp:1.0 --replicas=3
  ```

### 5️⃣ 외부에서 접근할 수 있도록 설정

- 애플리케이션을 외부에서 접근할 수 있도록 로드밸런서를 사용해 서비스를 노출시키고 이때, 포트 번호는 8999로 설정함

  ```bash
  kubectl expose deployment springapp --type=LoadBalancer --port=8999

  # service 확인 -> 이떄, 보면 springapp의 EXTERNAL-IP 부분이 <pending> 상태임
  kubectl get services

  # tunnel 열어주기
  minikube tunnel

  # service 재확인 -> 할당된 EXTERNAL-IP 확인
  kubectl get services
  ```

- URL을 VSCode 내에서 포트포워딩 설정

  ![화면 캡처 2024-10-02 121213](https://github.com/user-attachments/assets/d49b6205-07d8-47dc-af35-d5b1f0002042)


### 6️⃣ 애플리케이션 상태 확인

- 애플리케이션이 정상적으로 배포되었는지 확인하고, 3개의 리플리카가 잘 동작하는지 확인
  
  ```bash
  kubectl get pods
  ```
  ![image](https://github.com/user-attachments/assets/4ee3ea3b-268d-446c-90a5-63b4692e376a)

### 7️⃣ 로드밸런싱 테스트

- 노출된 URL로 애플리케이션에 접속하여 로드밸런싱이 작동하는지 테스트 수행
  
<p align="center">
  <img src="https://github.com/user-attachments/assets/f732f2a9-f767-4001-ac0b-f6d7d6466b68" width="300"/>
  <img src="https://github.com/user-attachments/assets/8b8151df-34cf-477e-9dad-89f7492f6446" width="500"/>
</p>

