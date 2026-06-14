# Banner

세모점 홈페이지 — 정적 페이지 (Google Cloud Run / nginx 배포)

## 구성

| 파일 | 설명 |
|---|---|
| `index.html` | 홈페이지 본문 (단일 HTML) |
| `IMG/` | 페이지에서 사용하는 이미지 |
| `Dockerfile` | nginx 기반 정적 사이트 컨테이너 |
| `nginx.conf` | Cloud Run 포트(8080) 설정 + 캐시/압축 |
| `.dockerignore` / `.gcloudignore` | 빌드 컨텍스트에서 제외할 파일 |

## 로컬에서 확인

```bash
# Docker 로 (실제 배포와 동일한 환경)
docker build -t semojum-web .
docker run --rm -p 8080:8080 semojum-web
# → http://localhost:8080

# 또는 간단히 (Python)
python -m http.server 8080
```

## Cloud Run 배포 (가장 쉬운 방법)

소스에서 바로 빌드·배포합니다. (`Dockerfile` 을 자동으로 사용)

```bash
# 1) 프로젝트 / 리전 설정 (최초 1회)
gcloud config set project <YOUR_PROJECT_ID>

# 2) 배포
gcloud run deploy semojum-web \
  --source . \
  --region asia-northeast3 \
  --allow-unauthenticated
```

배포가 끝나면 출력되는 `Service URL` 로 접속하면 됩니다.
이후 코드 수정 후 같은 명령을 다시 실행하면 새 버전이 올라갑니다.

> `asia-northeast3` 는 서울 리전입니다. 필요에 따라 변경하세요.
> 최초 배포 시 Artifact Registry / Cloud Build API 활성화 여부를 물으면 `y` 로 진행합니다.

## 참고

- 폰트(Pretendard)와 애니메이션(GSAP)은 CDN 에서 불러오며, 로드 실패 시에도
  시스템 폰트·기본 표시로 정상 동작하도록 폴백 처리되어 있습니다.
- `IMG/IMG_01~04.png` 일러스트는 원본 해상도(2816×1536, 각 ~4MB)라 용량이 큽니다.
  더 빠른 로딩이 필요하면 너비 1200px 내외로 리사이즈/WebP 변환을 권장합니다.
- 아직 실제 이미지가 없는 슬롯(서비스 메인화면·복합 레이아웃·처리 모드 3종)은
  `index.html` 안에 점선 플레이스홀더로 남겨두었습니다. 이미지를 `IMG/` 에 넣고
  해당 `<div class="imgph">` 를 `<div class="imgph real"><img ...></div>` 형태로 교체하면 됩니다.
