FROM clfoundation/sbcl:latest
WORKDIR /usr/src/app

EXPOSE 8080

CMD [ "/usr/src/app/cl-start" ]
