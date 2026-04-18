# Day 20 - ArgoCD GitOps

## 오늘 배운 것
- GitOps = Git이 진실의 원천
- ArgoCD = Git 변경사항을 K8s에 자동 동기화
- git push → ArgoCD 감지 → 자동 배포!

## 흐름
git push
    → ArgoCD가 Git 변경 감지
    → K8s 자동 동기화
    → Pod 자동 업데이트

## 핵심 명령어
kubectl port-forward -n argocd service/argocd-server 8080:443
argocd app sync webapp
