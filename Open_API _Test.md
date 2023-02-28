>Naver 도서 Open API Test    

<br/>

1. 먼저 Naver OpenAPI를 사용하기 위해서 OpenAPI 이용신청을 해야 한다.

    ![image](https://user-images.githubusercontent.com/90839206/220221491-234c9e01-16f7-4346-a65f-ccf8d980cd32.png)
    
<br/>

2. 신청을 완료하면 다음과 같이 클라이언트 아이디와 클라이언트 시크릿 값이 주어지는데 해당 값을 HTTP 요청 헤더에 포함시켜주면 된다.

    ![image](https://user-images.githubusercontent.com/90839206/220221315-4921555c-4c67-452f-b541-54823e4ab468.png)
    
<br/>

3. 요청 URL은 ' https://openapi.naver.com/v1/search/book.json ' 을 사용했다.
    
<br/>

4. 프로토콜은 HTTPS, HTTP 메서드는 GET이다.
    
<br/>

5. 파라미터로는 query, display, start, sort가 있다.

    + query : 검색어, **필수여부 Y**
    + diplay : 한번에 표시할 검색 결과 개수 ( 기본값: 1, 최댓값: 1000)
    + start: 검색 시작 위치(기본값: 1, 최댓값: 1000)
    + sort : 검색 결과 정렬 방법
        + sim: 정확도순으로 내림차순 정렬(기본값)
        + date: 출간일순으로 내림차순 정렬
    
<br/>

6. POSTMAN에 request를 생성해준다.

    ![image](https://user-images.githubusercontent.com/90839206/220222380-38854234-b1d9-47de-805b-db1bccc63693.png)
    
    HTTP 요청 헤더에 클라이언트 아이디와 클라이언트 시크릿 값을 포함시켜줘야한다.

    ![image](https://user-images.githubusercontent.com/90839206/220222118-1a293c5d-e332-445a-a3c4-fcdc9091ab20.png)    
<br/>

7. Send를 누르면 원하는 결과를 받아올 수 있다. 

    ![image](https://user-images.githubusercontent.com/90839206/220222674-9418fe0e-9589-4c10-a3e0-667b1e785add.png)
