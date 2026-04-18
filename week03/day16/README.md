# Day 16 - 완전 자동화 CI/CD 파이프라인

## 완성된 파이프라인
git push
    → GitHub Actions 자동 실행
    → Docker 이미지 빌드
    → DockerHub push
    → EC2 SSH 접속
    → 새 컨테이너 자동 배포
    → 브라우저 접속 성공!

## 사용한 기술
- GitHub Actions
- Docker + DockerHub
- AWS EC2
- Terraform
- SSH 자동 접속 (base64 키)

## 핵심 개념
- Secrets = 비밀번호 안전하게 저장
- base64 = 바이너리를 텍스트로 변환
- CI/CD = 코드 변경 → 자동 배포
