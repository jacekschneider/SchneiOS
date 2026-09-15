docker build -t schneios-creator . ;`
docker run --rm -it `
    -v "${PWD}:/project" `
    -v "schneios-work:/work" `
    -v "schneios-downloads:/downloads" `
    -v "schneios-sstate:/sstate" `
    -w /work `
    schneios-creator