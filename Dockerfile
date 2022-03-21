FROM ruby:slim

LABEL org.opencontainers.image.authors="diraneyya@ip.rwth-aachen.de"

# This is in order to have the man pages during exercises
RUN sed -i '/path-exclude \/usr\/share\/man/d' /etc/dpkg/dpkg.cfg.d/docker
RUN sed -i '/path-exclude \/usr\/share\/groff/d' /etc/dpkg/dpkg.cfg.d/docker
RUN apt update && apt install -y man git && apt install --reinstall coreutils

# The DATA_PATH is used for the deliverables, or the submissible
# content for the classroom activity.
ENV DATA_PATH="/data"
# The REPO_PATH is where the original or the teacher's forked repo
# resides inside the container.
ENV REPO_PATH="/root/githug"
# The LEVEL_PATH is where the current challenge resides and where
# students should navigate prior to attemping to use the `githug`
# commands.
ENV LEVEL_PATH="/git_hug"
ENV GITHUG_GITCONF="/root/.gitconfig"
ENV GITHUG_PROFILE="$LEVEL_PATH/.profile.yml"
ENV GITHUG_HISTORY_OUTPUT="$DATA_PATH/history.txt"
ENV GITHUG_PROFILE_OUTPUT="$DATA_PATH/profile.yml"
ENV GITHUG_GITCONF_OUTPUT="$DATA_PATH/gitconfig"

RUN mkdir -p $DATA_PATH
ADD . $REPO_PATH
WORKDIR $REPO_PATH
RUN gem build
RUN gem install *.gem

WORKDIR /
RUN echo "y" | $GEM_HOME/bin/githug
RUN cp $GITHUG_PROFILE $GITHUG_PROFILE_OUTPUT

WORKDIR $LEVEL_PATH

# The bash login script in below clears the history and restores
# progress using the contents of the $GITHUG_PROFILE_OUTPUT file.
RUN printf "history -c\nHISTSIZE= \nHISTFILESIZE= \n\
echo '--- NEW SESSION ---' >> $GITHUG_HISTORY_OUTPUT \n\
if ! [ -e $GITHUG_PROFILE_OUTPUT ]; then \n\
    echo 'ERROR: Corrupt level progress data. Exiting.' \n\
    echo '>>> CORRUPT DATA <<<' >> $GITHUG_HISTORY_OUTPUT \n\
    exit 1; fi \n\
cp $GITHUG_GITCONF_OUTPUT $GITHUG_GITCONF \n\
mkdir -p $LEVEL_PATH && cp $GITHUG_PROFILE_OUTPUT $GITHUG_PROFILE \n\
export PATH=\"\$GEM_HOME/bin:\$PATH\" \n\
cd $LEVEL_PATH && githug reset \n\
echo -e '\nIMPORTANT: everything you type in this container is \
recorded to assist in the grading process.' \n" >> ~/.bash_profile

RUN printf "history -a\ncat \$HISTFILE >> $GITHUG_HISTORY_OUTPUT \n\
cp $GITHUG_PROFILE $GITHUG_PROFILE_OUTPUT \n\
cp $GITHUG_GITCONF $GITHUG_GITCONF_OUTPUT 2>/dev/null \n\
cp $GITHUG_PROFILE $GITHUG_PROFILE_OUTPUT \n" >> ~/.bash_logout 

ENTRYPOINT ["/bin/bash", "--login"]
VOLUME $DATA_PATH
