FROM ruby:slim

LABEL org.opencontainers.image.authors="diraneyya@ip.rwth-aachen.de"

RUN apt update && apt install -y git

ENV DATA_PATH="/data"
ENV REPO_PATH="/root/githug"
ENV LEVEL_PATH="/git_hug"
ENV GITHUG_PROFILE_INPUT="$LEVEL_PATH/.profile.yml"
ENV GITHUG_HISTORY_OUTPUT="$DATA_PATH/history.txt"
ENV GITHUG_PROFILE_OUTPUT="$DATA_PATH/profile.yml"

RUN mkdir -p $DATA_PATH
ADD . $REPO_PATH
WORKDIR $REPO_PATH
RUN gem build
RUN gem install *.gem

WORKDIR /
RUN echo "y" | $GEM_HOME/bin/githug

WORKDIR $LEVEL_PATH

RUN printf "history -c\nHISTSIZE= \nHISTFILESIZE= \n\
echo '--- NEW SESSION ---' >> $GITHUG_HISTORY_OUTPUT\n\
export PATH=\"\$GEM_HOME/bin:\$PATH\"\ngithug reset\n" >> ~/.bashrc

RUN printf "history -a\ncat \$HISTFILE >> $GITHUG_HISTORY_OUTPUT\n\
cp $GITHUG_PROFILE_INPUT $GITHUG_PROFILE_OUTPUT" >> ~/.bash_logout 
RUN printf ". ~/.bashrc\n" > ~/.bash_profile

ENTRYPOINT ["/bin/bash", "--login"]
VOLUME $LEVEL_PATH
VOLUME $DATA_PATH
