## 📌실습 내용

- Docker에 trivy를 설치하고, trivy를 사용하여 이미지 분석하기

## 💡실습 목표

- trivy를 사용하여 nginx의 컨테이너 이미지를 분석하고, 심각도에 따른 취약점 확인하기

## 🧾실습 과정

### 1️⃣ Docker에 trivy 설치하기

```bash
sudo docker pull aquasec/trivy
```

### 2️⃣ trivy로 nginx 이미지 취약점 스캔하고, 분석 결과 저장하기

```bash
docker run --rm -v /home/username/trivy:/root/.cache aquasec/trivy image nginx --format json \
    > /home/username/trivy/nginx_scan_results.json
```

![화면 캡처 2024-09-25 114953](https://github.com/user-attachments/assets/0f2b5cd4-90d0-45bf-a515-f67b3e99d928)

### 3️⃣ 
