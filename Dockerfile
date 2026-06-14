# 세모점 홈페이지 — 정적 사이트 (Google Cloud Run / nginx)
FROM nginx:1.27-alpine

# Cloud Run 기본 포트(8080)로 listen 하도록 서버 설정 교체
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 정적 파일 복사
COPY index.html /usr/share/nginx/html/index.html
COPY IMG/ /usr/share/nginx/html/IMG/

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
