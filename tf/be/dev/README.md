
# 1. terraform 실행
```
 $ terraform apply
```
   
# 2. cicd instance에 접속하여 kubeConfig update
> cicd 인스턴스에는 이미 aws cli와 kubectl 이 설치가 되어 있음.
> aws eks --region {리전} update-kubeconfig --name {클러스터 이름}

```
$ aws eks --region ap-northeast-2 update-kubeconfig --name mp-dban2-eks-cluster
```

# 3. cicd instance 기본 설치 항목
> 만약 2번 작업의 instance에 해당 항목이 없는 경우 설치 필요
## 3-1) AWS CLI 설치
```
$ sudo apt-get update
$ sudo apt-get upgrade -y
$ sudo apt install awscli -y

- 확인
$ aws

- configure
$ aws configure
$ aws configure list

- Global settings(글로벌 설정)
$ export AWS_ACCESS_KEY_ID={AWS_ACCESS_KEY_ID}
$ export AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}
$ export AWS_DEFAULT_REGION=ap-northeast-2

- 확인
aws ec2 describe-instances
```

## 3-2) kubectl 설치
```
- 설치
$ curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
$ chmod +x ./kubectl
$ mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
$ echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
$ kubectl version --short --client

- autocompletion
$ echo 'source <(kubectl completion bash)' >>~/.bashrc
$ source ~/.bashrc
```