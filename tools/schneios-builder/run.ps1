docker build -t schneios-creator kas ;`
docker run --rm -it `
    -v "${PWD}:/project" `
    -v "schneios-work:/work" `
    -v "schneios-downloads:/downloads" `
    -v "schneios-sstate:/sstate" `
    -w /work `
    -e KAS_WORK_DIR=/work `
    schneios-creator