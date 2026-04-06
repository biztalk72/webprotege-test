#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== WebProtégé on Colima (Docker) 테스트 환경 구성 ==="

# 1. Colima 시작
echo ""
echo "[1/4] Colima 시작 중..."
if colima status 2>/dev/null; then
  echo "  -> Colima가 이미 실행 중입니다."
else
  colima start --cpu 2 --memory 4
  echo "  -> Colima 시작 완료."
fi

# 2. Docker Compose 실행
echo ""
echo "[2/4] WebProtégé 컨테이너 기동 중..."
docker compose -f "$PROJECT_DIR/docker-compose.yml" up -d
echo "  -> 컨테이너 기동 완료."

# 3. WebProtégé 기동 대기
echo ""
echo "[3/4] WebProtégé 기동 대기 중 (최대 120초)..."
for i in $(seq 1 24); do
  if curl -s -o /dev/null -w "%{http_code}" http://localhost:5001 | grep -q "200\|302"; then
    echo "  -> WebProtégé 가 준비되었습니다."
    break
  fi
  if [ "$i" -eq 24 ]; then
    echo "  -> 타임아웃. 로그를 확인해주세요: docker compose logs webprotege"
    exit 1
  fi
  echo "  ... 대기 중 ($((i*5))초)"
  sleep 5
done

# 4. Admin 계정 생성
echo ""
echo "[4/4] Admin 계정 생성 중..."
docker exec -i webprotege java -jar /webprotege-cli.jar create-admin-account <<EOF
admin
admin@webprotege.local
admin123
admin123
EOF
echo "  -> Admin 계정 생성 완료 (또는 이미 존재)."

echo ""
echo "========================================="
echo " WebProtégé 테스트 환경 구성 완료!"
echo " URL: http://localhost:5001"
echo " 계정: admin / admin123"
echo "========================================="
