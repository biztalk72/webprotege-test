# WebProtégé on Colima (Docker) 테스트 환경

## 구성요소
- **WebProtégé** — 온톨로지 편집기 (웹 기반)
- **MongoDB 4.4** — 데이터 저장소

## 빠른 시작

```bash
# 자동 설정 (Colima 시작 + 컨테이너 + admin 계정)
chmod +x setup.sh
./setup.sh
```

## 수동 시작

```bash
# 1. Colima 시작
colima start --cpu 2 --memory 4

# 2. 컨테이너 기동
docker compose up -d

# 3. Admin 계정 생성 (최초 1회)
docker exec -it webprotege java -jar /webprotege-cli.jar create-admin-account

# 4. 브라우저 접속
open http://localhost:5001
```

## 접속 정보
- **URL**: http://localhost:5001
- **Admin 계정**: `admin` / `admin123` (setup.sh 사용 시)

## 관리 명령어

```bash
# 상태 확인
docker compose ps

# 로그 확인
docker compose logs -f webprotege

# 중지
docker compose down

# 데이터 포함 완전 삭제
docker compose down -v
```

## macOS 참고사항
- macOS의 AirPlay Receiver가 포트 5000을 사용하므로, 포트 **5001**로 매핑되어 있습니다.
- Apple Silicon Mac에서는 `platform: linux/amd64` 에뮬레이션으로 동작합니다.
