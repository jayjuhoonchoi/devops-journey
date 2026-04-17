# Day 15 - GitHub Actions CI/CD

## 오늘 배운 것
- GitHub Actions = 코드 push시 자동 실행되는 파이프라인
- Secrets = 비밀번호를 안전하게 저장하는 방법
- Docker 이미지 자동 빌드 & DockerHub push 성공!

## 파이프라인 흐름
git push
    → GitHub Actions 자동 실행
    → Docker 이미지 빌드
    → DockerHub push 완료!

## 내일 할 것
- EC2 자동 배포 추가
- push → 빌드 → 실제 서버 자동 업데이트!
