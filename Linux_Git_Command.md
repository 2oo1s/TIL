#Linux, Git 명령어 학습 내용  
<br/> 

>Linux Command
1. 디렉토리
    + ls : 현재 또는 지정한 디렉토리에 있는 파일 및 디렉토리를 화면에 출력
    + cd : 작업 디렉토리를 이동
      + cd [하위_디렉토리명] 현재 디렉토리에 있는 하위_디렉토리로 이동
      + cd .. 한 단계 상위 디렉토리로 이동
      + cd ../.. 두 단계 상위 디렉토리로 이동
    + mkdir[디렉토리_경로] : 새 디렉토리를 생성
      + mkdir Ex1/SubDir Ex1 디렉토리가 존재하는 경우, Ex1 디렉토리 하위에 SubDir 디렉토리 생성
      + mkdir -p Ex1/SubDir/SubSubDir 중간 디렉토리가 존재하지 않는 경우, 중간 디렉토리를 함께 생성
    + rmdir [디렉토리_경로] : 비어있는 디렉토리를 제거  
  <br/>  

2. 파일
    + touch [옵션][파일명] : 새로운 빈 파일을 생성하거나, 파일의 타임스탬프를 변경
        + touch -t [yyyyMMddHHmm.ss][파일명] 해당 파일의 타임스탬프를 지정한 시간으로 변경
    + cat : 파일의 내용을 입력하거나, 파일의 내용을 화면에 출력
    + head [옵션][파일_경로] : 파일의 앞부분을 화면에 출력
      + head -[num] 행의 앞부분부터 [num]행까지 출력
    + tail [옵션][파일_경로] : 파일의 뒷부분을 화면에 출력
      + tail -[num] 행의 마지막 [num]행을 출력
    + cp [옵션] [원본_경로] [사본_경로] : 파일을 다른 파일 또는 디렉토리로 복사
      + cp [파일명_또는_경로] [새_파일명_또는_경로] 지정한 파일을 특정 경로에 파일명을 변경하여 복사
        + ex) cp file.txt SubDir/file2.txt
      + cp [파일명_또는_경로] [디렉토리명_또는_경로] 지정한 파일을 특정 디렉토리 안에 복사(파일명 유지)
        + cp file.txt SubDir/
   + mv [옵션] [원본_경로] [이동될_경로] : 파일(디렉토리)을 다른 파일 또는 디렉토리로 이동하거나 이름을 변경
   + rm [옵션] [삭제할_파일(디렉토리)_경로] : 파일 또는 디렉토리를 삭제
   + file : 파일의 종류를 화면에 출력  
  <br/> 
  
>Git Command
1. git 설정하기
   + git config --global user.name "이름" : 사용자 이름 설정
   + git config --global user.mail "이메일" : 사용자 메일 설정  
  <br/> 
  
2. git 저장소 만들기
   + git init 저장소를 생성(초기화)
   + git clone [url] 저장소를 복제  
  <br/> 
  
3. git 파일 상태
   + git status 파일이 어떤 상태인지 아래 4단계로 알려줌
     + Untracked, Unmodified, Modified, Staged
   + git add Untracked 상태인 파일을 Tracked 상태로 변경할 수 있고, Modified 파일을 Staged 상태로 변경할 수 있음
   + git commit Modified 된 파일을 Staged 상태로 커밋  
  <br/> 
  
4. git 관리
   + git push [remote] [branch] commit 된 프로젝트를 저장소에 업로드
   + git remote 연동된 원격저장소 확인
   + git branch 연동된 브랜치 확인
   + git merge [branch] 다른 branch와 합치는 과정
   + git pull [remote] [branch] 원격저장소의 최신 내용을 가져와서 병합
