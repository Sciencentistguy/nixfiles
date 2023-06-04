{pkgs, ...}: {
  services.nfs.server.exports = ''
    /storage-pool/   100.64.0.0/10(rw,fsid=0,no_subtree_check,insecure,nohide)
    /storage-pool/   192.168.1.0/24(rw,fsid=0,subtree_check,insecure,nohide)
    /nas/   100.64.0.0/10(rw,fsid=0,no_subtree_check,insecure,nohide)
  '';

  services.nfs.server = {
    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };
  networking.firewall = {
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [111 2049 4000 4001 4002 20048];
    allowedUDPPorts = [111 2049 4000 4001 4002 20048];
  };
}
