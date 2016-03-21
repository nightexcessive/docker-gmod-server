FROM ubuntu:14.04

MAINTAINER Michael Johnson <michael AT johnson DOT computer>

# ------------
# Prepare Gmod
# ------------

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates lib32gcc1 lib32stdc++6 wget
RUN mkdir /opt/steamcmd
WORKDIR /opt/steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz
RUN mkdir /opt/gmod
RUN /opt/steamcmd/steamcmd.sh +login anonymous +force_install_dir /opt/gmod +app_update 4020 validate +quit


# ---------------
# Setup Container
# ---------------

EXPOSE 27015/udp

ENV MAXPLAYERS="8"
ENV MAP="gm_construct"
ENV GAMEMODE="sandbox"
ENV GMOD_HOSTNAME="Garry's Mod"
ENV STEAM_API_KEY=""
ENV STEAM_SERVER_ACCOUNT=""
ENV PASSWORD=""

# Run options

WORKDIR /opt/gmod
CMD /opt/gmod/srcds_run -console -game garrysmod +log off +gamemode "${GAMEMODE}" +map "${MAP}" +maxplayers "${MAXPLAYERS}" -authkey "${STEAM_API_KEY}" +sv_setsteamaccount "${STEAM_SERVER_ACCOUNT}" +hostname "${GMOD_HOSTNAME}" +sv_password "${PASSWORD}"
