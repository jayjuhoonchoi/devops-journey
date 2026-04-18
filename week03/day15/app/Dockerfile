# 베이스 이미지를 최신으로 업데이트
FROM python:3.11-slim

# 보안: root가 아닌 일반 유저로 실행
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# 패키지 최신 보안 업데이트 적용
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Python 패키지 업데이트
RUN pip install --upgrade pip wheel jaraco.context

COPY app.py .

# root 대신 appuser로 실행
USER appuser

EXPOSE 5000

CMD ["python3", "app.py"]
