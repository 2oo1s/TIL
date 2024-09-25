## 📌실습 내용

- Trivy를 사용하여 컨테이너 이미지를 분석하고, 분석 결과를 메일로 받아보기

## 💡실습 목표

- Docker에 Trivy를 설치한 후, nginx 컨테이너 이미지를 분석하고 심각도에 따른 취약점 확인하기
- 분석 결과를 텍스트 파일로 저장 후, SMTP를 통해 메일로 전송하기

- crontab으로 매일 오전 10시에 분석 취약 결과 정보 받을 수 있도록 설정하기

## 🧾실습 과정

### 1️⃣ Docker에 Trivy 설치하기

```bash
sudo docker pull aquasec/trivy
```

### 2️⃣ Trivy로 nginx 이미지 스캔하고 실행 후, 텍스트 파일로 결과 저장

```bash
docker run --rm -v /home/username/trivy:/root/.cache aquasec/trivy image nginx \
     > /home/username/trivy/nginx_scan_results.txt 2>/home/username/trivy/error_log.txt
```

- 취약점 분석 결과 확인

  ![화면 캡처 2024-09-25 152848](https://github.com/user-attachments/assets/2c7b43b1-7689-4bc3-91ad-0c1b3e455f4a)

### 3️⃣ 메일 전송을 위한 SMTP 설정하기

- 설정 파일을 열어주기

  ```bash
  sudo vi /etc/postfix/main.cf
  ```

- 설정 파일 수정하기

  ```bash
  relayhost = [smtp.gmail.com]:587

  # 하단에 추가
  smtp_sasl_auth_enable = yes
  smtp_sasl_security_options = noanonymous
  smtp_tls_security_level = may
  smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
  smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
  ```

  ![화면 캡처 2024-09-25 153256](https://github.com/user-attachments/assets/09df0497-5a48-4b07-bb12-ddc2feea275e)

  - 설정 파일 중 수정한 부분만 캡쳐한 것임

- Postfix에서 SMTP 서버에 인증하기 위해 `sasl_passwd` 파일에 사용자 메일과 비밀번호 설정

  ```bash
  sudo nano /etc/postfix/sasl_passwd

  [smtp.gmail.com]:587 your-email@gmail.com:your-password
  ```

  ![화면 캡처 2024-09-25 153452](https://github.com/user-attachments/assets/38bf3508-13c2-4770-bc80-b2a72bcf40be)

  - 이때, 비밀번호는 구글 계정 2단계 보안 인증에서 앱 비밀번호를 설정해줬을 때 받은 값으로 설정해줌

- Postfix가 `sasl_passwd` 파일을 읽을 수 있게 Hash 테이블로 변경 및 파일 권한 설정 및 재시작

  ```bash
  sudo postmap /etc/postfix/sasl_passwd
  sudo chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
  sudo systemctl restart postfix
  ```

- 메일이 정상적으로 보내지는지 확인

  ```bash
  echo "Test mail from Postfix" | mail -s "Test Subject" 2oo1s@naver.com
  ```

  <img src="https://github.com/user-attachments/assets/1b446129-5b70-4fa8-ae30-bd01ad86efdd" alt="IMG_1199" width="400"/>

### 4️⃣ 저장된 결과를 첨부 파일로 추가하여 메일 보내기

- trivy_scan.sh 파일 작성

  ```shell
  #!/bin/bash

  # Trivy 스캔 실행 및 결과를 파일로 저장
  docker run --rm -v /home/username/trivy:/root/.cache aquasec/trivy image nginx > /home/username/trivy/nginx_scan_results.txt 2>/home/username/trivy/error_log.txt

  # 결과를 이메일로 발송 (파일 첨부)
  echo "Trivy scan results attached." | mutt -s "Trivy Scan Results" -a /home/username/trivy/nginx_scan_results.txt -- 2oo1s@naver.com
  ```

- shell 파일 실행

  ```bash
  ./trivy_scan.sh
  ```

    <img src="https://github.com/user-attachments/assets/0cda072a-f079-48c4-8156-a7a02a3f9030" alt="IMG_1199" width="400"/>

### 5️⃣ Crontab으로 매일 오전 10시에 자동으로 메일 전송 설정하기

- crontab 설정 코드 작성

  ```bash
  crontab -e

  # 열린 설정 파일에 아래 코드 추가
  # 0 10 * * * /bin/bash /home/username/trivy_scan.sh

  # 테스트를 할 때는 정상 작동하는지 1분마다 오게 설정
  */1 * * * * /bin/bash /home/username/trivy_scan.sh
  ```

- crontab 설정 확인

  ```bash
  crontab -l
  ```

  <img src="https://github.com/user-attachments/assets/8fb0ec86-c8da-4aab-9fb6-c03d5c00863e" alt="IMG_1199" width="400"/>

### 6️⃣ 메일 확인하기

- 1분마다 정상적으로 전송됨

    <img src="https://github.com/user-attachments/assets/3dc0a321-b30a-484f-9279-67de85c8274f" alt="IMG_1199" width="400"/>
