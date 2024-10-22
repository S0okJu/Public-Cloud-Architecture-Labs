### Public Cloud Architecture Labs

Public Cloud 아키텍쳐를 설계하고 직접 구축하는 연습장

##### setup
`tf_setup.sh`를 사용하면  main.tf, variables.tf, outputs.tf 파일이 있는 모듈로 구성된 테라폼 파일을 만들어 줍니다.
```sh
chmod +x tf_setup.sh
./tf_setup.sh -p [project_directory] -m [module_name ...]
```

##### 예시
```sh
./tf_setup -p my_project -m vpc ec2
```

```
my_project/
├── main.tf
├── modules
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```
