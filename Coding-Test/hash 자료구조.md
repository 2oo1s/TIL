## 1. HashSet function

- isEmpty()

  - hash가 비어있으면 true, 아니면 false를 반환

- add()

  - hash에 값을 추가

- remove(Obejct o)

  - hash에 값을 제거하는 함수 (삭제되면 true, 아니면 false)

- clear()

  - hash를 비우는 함수

- size()

  - HashSet 사이즈 반환하는 함수

- contains(Object o)

  - hash에 값을 포함하면 true, 아니면 false 반환

## 2. HashMap function

- put(key,value)

  - (key,value) 쌍으로 HashMap에 저장

- clear()

  - HashMap을 비움

- containsKey(object key)

  - 해당 key를 포함하면 true, 아니면 false 반환

- containsValue(object value)

  - 해당 value를 포함하면 true, 아니면 false 반환

- entrySet()

  - HashMap에 들어있는 값들을 entry <key, value> 형태로 Hashtable 순서대로 반환

- keySet()

  - HashMap에 들어있는 key값들을 Hashtable 순서대로 반환

- values()

  - HashMap에 들어있는 value값들을 Hashtable 순서대로 반환

- remove(object key)

  - 해당 key의 값을 hashtable에서 삭제

- get(object key)

  - 해당 key에 해당하는 value값을 가져옴

- comparator()

  - hash값들을 비교해서 정렬하는 함수

  - overwriting으로 구현

  - object o1, object o2 두개의 값을 비교해서 key or value or 사용자가 설정한 방법으로 정렬 가능

- getOrDefault(Object key, V DefaultValue)

  - 찾는 key가 존재한다면 찾는 키의 값을 반환하고, 키가 없다면 기본 값을 반환

  - ex) BOJ_17140.java
    ```java
    for (int j = 1; j <= curColCount; j++) { // 숫자랑 등장횟수 저장
    	if (arr[i][j] != 0)
    		frequency.put(arr[i][j], frequency.getOrDefault(arr[i][j], 0) + 1);
    }
    ```

## 3. TreeSet

- HashSet과 달리 자동으로 오름차순으로 정렬됨

## 4. TreeMap

- HashMap과 달리 key를 기준으로 자동으로 오름차순으로 정렬됨
