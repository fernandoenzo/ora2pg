FROM ghcr.io/fernandoenzo/debian:testing AS oracle-drivers
COPY scripts/oracle-drivers /tmp
RUN bash /tmp/oracle-drivers

FROM ghcr.io/fernandoenzo/debian:testing
COPY scripts/final /tmp
COPY --from=oracle-drivers /*.deb /tmp
COPY --from=oracle-drivers /usr/local/man/man3/ /usr/local/man/man3/
COPY --from=oracle-drivers /usr/local/lib/x86_64-linux-gnu/perl/ /usr/local/lib/x86_64-linux-gnu/perl/
RUN bash /tmp/final

ENV LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
ENV ORACLE_HOME=/usr/lib/oracle/21/client64
ENV PATH="/usr/lib/oracle/21/client64/bin":$PATH