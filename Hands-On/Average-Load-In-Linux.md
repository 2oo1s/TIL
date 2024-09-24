## 📌실습 내용

- Linux에서 평균 부하를 이해하기 위한 간단한 실습 예제 구성하고 테스트 진행

## 💡실습 목표

- 시스템의 평균 부하 확인 및 CPU 부하를 증가시키고 평균 부하의 변화를 관찰

## 🧾실습 과정

### 1️⃣ `uptime`으로 평균 부하 확인하기

  ```bash
  username@servername:~$ uptime
  14:24:17 up  7:18,  1 user,  load average: 0.08, 0.60, 0.47
  ```

### 2️⃣ CPU 부하 생성하기

- 부하를 증가시키기 위해 stress 패키지 사용

  - `sudo apt install stress`로 패키지 설치

- `stress --cpu 4 -- timeout 60` 명령어 실행

  ![image](https://github.com/user-attachments/assets/6aa7d0c2-72ef-4c01-8d73-6ed99b85096f)

  - 4개의 CPU 코어를 60초 동안 사용하여 부하를 생성

- `stress --cpu 2 -- timeout 60` 명령어 실행

  ![image](https://github.com/user-attachments/assets/5346b6b7-e17b-4bd3-a601-e893841dde4c)

  - 2개의 CPU 코어를 60초 동안 사용하여 부하를 생성

### 3️⃣ 결과 분석

- `--cpu 4`의 경우, 1분 평균 부하가 2.74라는 것은 CPU 사용률이 상당히 높다는 것을 의미

  - 이 경우, CPU가 과부하 상태에 가까운 것으로 볼 수 있음

- `--cpu 2`의 경우,1분 평균 부하가 1.06이라는 것은 시스템이 적절하게 부하를 처리하고 있음을 의미
