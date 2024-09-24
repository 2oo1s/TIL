## 📌실습 내용

- 효율적인 자원 활용, 빠른 배포, 강화된 보안을 위해 Docker 이미지 크기를 최적화하는 과정을 기획하고 구현하는 과정 진행

## 💡실습 목표

- <b>Multi-Stage Builds</b>로 Docker Image 크기를 최적화

  - Multi-Stage Builds란? 여러 개의 빌드 스테이지를 정의하여 빌드 과정에서 생성되는 불필요한 파일이나 의존성을 최종 이미지에서 제거함으로써 이미지의 크기를 줄이고 보안성을 높임

- Java 파일을 빌드 단계와 런타임 단계를 분리하여, class 파일만 최종 이미지에 포함되도록 하여 Multi-Stage Builds를 사용 안했을 때 만든 이미지와의 크기 비교

## 🧾실습 과정

### 1️⃣ Multi-Stage Builds를 통해 Image 생성

- Dockerfile 작성

  ```Docker
  # 빌드 환경
  FROM openjdk:17 AS build
  WORKDIR /usr/src/myapp

  COPY Main.java .

  # java 파일 컴파일
  RUN javac Main.java

  # 런타임 환경
  FROM openjdk:17-jdk-slim
  WORKDIR /usr/src/myapp

  COPY --from=build /usr/src/myapp/Main.class .

  # 파일 실행
  CMD ["java", "Main"]
  ```

- Docker Image로 생성

  ```bash
  docker build -t optimg1 .
  docker tag optimg1 2oo1s/optimg1:1.0
  ```

  ![image](https://github.com/user-attachments/assets/021b8f23-6c82-4cbb-8173-93e5b322bc03)

### 2️⃣ 파일 분리하지 않고 Image 생성

- Dockerfile 작성

  ```Docker
  FROM openjdk:17
  COPY . /usr/src/myapp
  WORKDIR /usr/src/myapp
  RUN javac Main.java
  CMD ["java", "Main"]
  ```

- Docker Image로 생성

  ```bash
  docker build -t optimg2 .
  docker tag optimg2 2oo1s/optimg2:1.0
  ```
  ![image](https://github.com/user-attachments/assets/551776d3-d9b0-4c46-9e10-35bf83822056)

### 3️⃣생성된 Image 크기 확인

  ![image](https://github.com/user-attachments/assets/39a8cfbd-7449-4c9e-ac6c-24d87e1abae7)

  - 사진에서 보이는 거와 같이, Multi-Stage Builds를 통해 생성한 optimg1이 Multi-Stage Builds를 사용하지 않은 optimg2보다 63MB만큼 크기가 줄어든 것을 확인할 수 있음
