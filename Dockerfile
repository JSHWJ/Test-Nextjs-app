#Next.js 앱을 도커로 실행하기 위한 설정
#베이스 이미지로 Node.js 공식 slim 버전을 사용한다.
FROM node:23-slim

#앱 실행 디렉토리를 생성하고, 작업 디렉토리로 지정한다.
WORKDIR /app

#Next.js 앱의 의존성 설치를 위해 package.json이랑 package-lock.json을 복사한다.
COPY package*.json ./

#의존성 설치, npm ci는 ci/cd 환경에서 빠르게 설치할 때 사용하는 명령어임
RUN npm ci

#프로젝트 전체를 복사한다.
COPY . .

#Next.js 앱을 프로덕션용으로 빌드한다.
RUN npm run build

# node 유저로 권한 전환, 실행을 비루트 유저로 한다.
USER node

#3000 포트를 컨테이너 외부와 연결
EXPOSE 3000

#컨테이너 실행 시 next start 명령어 실행
CMD ["npm","run","start"]
