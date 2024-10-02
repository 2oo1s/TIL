# 🔮 MySQL DB 데이터 덤프 및 다른 컨테이너 내 DB로 마이그레이션하는 과정 자동화 설정

## 💡 실습 목표

- MySQL DB의 테이블의 데이터를 덤프한 후, 이를 다른 컨테이너의 동일한 데이터베이스에 저장하는 쉡 스크립트 작성 및 과정 이해
  
- Docker와 크론탭을 사용하여 주기적인 백업 프로세스 구현

## 🧾 실습 과정

### 1️⃣ 현재 테이블 목록 저장

- `SHOW TABLES` 명령어를 사용하여 `fisa` 데이터베이스의 테이블 목록을 `/tmp/current_tables.txt`에 저장

  ```bash
  docker exec mysqldb mysql -u $MYSQL_USER -p "$MYSQL_PASS" -e \
              "SHOW TABLES IN $SOURCE_DB_NAME;" > /tmp/current_tables.txt
  ```

### 2️⃣ 테이블 덤프 및 복사

- 각 테이블을 순회하며 `mysqldump`를 사용하여 덤프 파일을 생성하고, 이를 로컬 디렉토리에 저장
  
- 생성된 덤프 파일을 `newmysqldb` 컨테이너로 복사하고, 해당 컨테이너에서 SQL 파일을 실행하여 데이터를 저장

  ```bash
  while read -r TABLE; do
    if [ "$TABLE" != "Tables_in_${SOURCE_DB_NAME}" ]; then  # 헤더 제거
        echo "Backing up table: $TABLE"
        docker exec mysqldb sh -c "mysqldump -u $MYSQL_USER -p'$MYSQL_PASS'\
                                $SOURCE_DB_NAME $TABLE > $TABLE_DUMP_DIR/$TABLE.sql"
        docker cp mysqldb:$TABLE_DUMP_DIR/$TABLE.sql $DUMP_STORE_DIR
        docker cp $DUMP_STORE_DIR/$TABLE.sql newmysqldb:$TABLE_DUMP_DIR/$TABLE.sql
        docker exec newmysqldb sh -c "mysql -u $MYSQL_USER -p'$MYSQL_PASS'\
                                    $TARGET_DB_NAME < $TABLE_DUMP_DIR/$TABLE.sql"
    fi
  done <$TABLE_DUMP_DIR/current_tables.txt
  ```

### 3️⃣ 데이터베이스 생성 확인

- `newmysqldb` 컨테이너에서 `fisa` 데이터베이스가 존재하는지 확인하고, 없을 경우 생성

  ```bash
  docker exec newmysqldb mysql -u $MYSQL_USER -p "$MYSQL_PASS" -e \
              "CREATE DATABASE IF NOT EXISTS $TARGET_DB_NAME;"
  ```

### 4️⃣ 자동화 파일 전체 코드

  ```shell
  #!/bin/bash
  
  # MySQL 데이터베이스 정보
  SOURCE_DB_NAME="fisa" # 데이터 가져올 DB
  TARGET_DB_NAME="fisa" # 데이터 복사할 DB
  MYSQL_USER="root"
  MYSQL_PASS="root"
  DUMP_STORE_DIR="/home/username/step06Compose/dumpData"
  TABLE_DUMP_DIR="/tmp" # 컨테이너 내 덤프 파일을 저장할 디렉토리
  
  # 현재 테이블 목록 저장
  docker exec mysqldb mysql -u $MYSQL_USER -p"$MYSQL_PASS" -e "SHOW TABLES IN $SOURCE_DB_NAME;" \
      >/tmp/current_tables.txt
  
  # 타겟 데이터베이스가 존재하는지 확인하고 생성
  docker exec newmysqldb mysql -u $MYSQL_USER -p"$MYSQL_PASS" \
      -e "CREATE DATABASE IF NOT EXISTS $TARGET_DB_NAME;"
  
  # 테이블을 순회하며 덤프 및 가져오기
  while read -r TABLE; do
      if [ "$TABLE" != "Tables_in_${SOURCE_DB_NAME}" ]; then # 헤더 제거
          echo "Backing up table: $TABLE"
  
          # 테이블 백업 (컨테이너 내부에서 실행)
          docker exec mysqldb sh -c "mysqldump -u $MYSQL_USER -p'$MYSQL_PASS' \
  $SOURCE_DB_NAME $TABLE > $TABLE_DUMP_DIR/$TABLE.sql"
  
          # 백업 파일을 로컬로 복사
          docker cp mysqldb:$TABLE_DUMP_DIR/$TABLE.sql $DUMP_STORE_DIR
  
          # newmysqldb 컨테이너에 데이터 가져오기
          docker cp $DUMP_STORE_DIR/$TABLE.sql newmysqldb:$TABLE_DUMP_DIR/$TABLE.sql
          docker exec newmysqldb sh -c "mysql -u $MYSQL_USER -p'$MYSQL_PASS' \
  $TARGET_DB_NAME < $TABLE_DUMP_DIR/$TABLE.sql"
  
          # 로컬 백업 파일 삭제
          # rm $DUMP_STORE_DIR/$TABLE.sql
      fi
  done <$TABLE_DUMP_DIR/current_tables.txt
  ```

### 5️⃣ 크론탭 설정

- 스크립트를 매주 월요일 오전 9시에 자동으로 실행하기 위한 크롭탭 설정

  ```bash
  crontab -e

  # 아래 명령어 추가
  0 9 * * 1 /home/username/step06Compose/dumpData/data_dump.sh
  ```

위와 같이 설정하면 매주 월요일 오전 9시에 해당 스크립트가 실행되어 자동으로 데이터베이스가 백업됨

### ✅ 활용 방안

1. 주기적인 데이터 백업: 자동화된 스크립트를 사용하여 데이터 손실을 방지하고, 주기적으로 백업하여 안정적인 데이터 관리가 가능힘

2. 데이터 마이그레이션: 개발 환경과 프로덕션 환경 간의 데이터 이전 작업을 자동화하여 효율성을 높일 수 있음

3. 비상 복구 계획: 데이터 손실이나 서버 장애 발생 시, 신속하게 데이터를 복구하여 비즈니스 연속성을 확보할 수 있음
