FROM alpine
ENTRYPOINT ["echo", "Hello World!"]
name: Docker GitHub

on: [push, pull_request,workflow_dispatch]

jobs:
  build-and-push-images:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
      - name: Build and push Docker image
    uses: docker/build-push-action@ad44023a93711e3deb337508980b4b5e9bcdc5dc
    with:
      context: .  //Contexto para el comando Docker
      push: false //Indicamos si queremos hacer push de la imagen
      
      - name: Login to DockerHub
        if: github.ref == 'refs/heads/master'
        uses: docker/login-action@v1 
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
          
      - name: Build and push Docker image
    uses: docker/build-push-action@ad44023a93711e3deb337508980b4b5e9bcdc5dc
    with:
      context: .
      push: true
      tags: 'fixedbuffer/hello'
      
    - name: Docker meta
        id: meta
        uses: docker/metadata-action@v3
        with:
          images: |
            fixedbuffer/hello
          tags: |
            latest
            type=sha
