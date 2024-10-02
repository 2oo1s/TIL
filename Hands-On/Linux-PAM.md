# 🔮 VM 고정 IP 설정 및 PAM 모듈로 비밀번호 설정 규제하기

- VM 고정 IP를 설정하고, PAM 모듈을 사용하여 비밀번호를 8자리 이상으로 규제하고 규제가 알맞게 적용되는지 확인하기
  
## 💡 실습 목표

- 새로 생성한 가상머신이 기존 가상 머신들과의 IP 충돌을 방지하고, 가상 머신들 간의 통신을 가능하게 만듦
  
- 비밀번호 규제 설정을 통해 더 강력한 사용자 인증을 구현

## 🧾 VM 고정 IP 설정 방법

#### 1️⃣ yaml 파일을 열기

```bash
sudo vi /etc/netplan/00-installer-config.yaml
```

#### 2️⃣ 아래 내용들을 작성하여 설정을 변경

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      addresses:
        - 10.0.2.19/24 # 변경된 고정 IP 주소
      routes:
        - to: default
          via: 10.0.2.1 # 게이트웨이
      nameservers:
        addresses:
          - 8.8.8.8
      dhcp4: false
```

#### 3️⃣ 변경사항을 적용

```bash
sudo netplan apply
```

#### 4️⃣ IP가 정상적으로 변경되었는지 확인

![image](https://github.com/user-attachments/assets/4cac284d-7636-4aa9-b767-e83f7e5128cc)

#### 5️⃣ Virtual Box 도구 -> [네트워크] -> [NAT 네트워크] -> [포트 포워딩] 설정 추가

![image](https://github.com/user-attachments/assets/ec42d64a-baef-4106-897a-254ef0d11f9a)

#### 6️⃣ 가상머신 간의 통신이 잘 되는지 ping test 수행

![image](https://github.com/user-attachments/assets/bba57995-5f06-4698-a6db-48973c385988)

- myserver01 ↔ myserver03 ping 성공

## 🧾PAM 모듈을 사용하여 비밀번호 규제 방법

#### 1️⃣ 필요한 패키리를 설치

```bash
sudo apt-get install libpam-pwquality
```

#### 2️⃣ 설정 파일 열기

```bash
sudo nano /etc/pam.d/common-password
```

#### 3️⃣ 아래 내용을 작성하여 설정을 변경

```bash
password requisite pam_pwquality.so retry=3 minlen=8
```

#### 4️⃣ 규칙이 제대로 반영되는지 확인

![image](https://github.com/user-attachments/assets/7fda81a5-fe44-49d2-8eb2-c8149643b8ad)

- 새로운 비밀번호를 1234로 설정하고자 한 경우 -> 실패

![image](https://github.com/user-attachments/assets/05afc24e-0820-4473-a2aa-04d246549be6)

- 새로운 비밀번호로 helloworld를 쳤을 경우 -> 성공
