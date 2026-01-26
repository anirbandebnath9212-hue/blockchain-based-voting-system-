window.getEthereumAccount = async () => {
  if (typeof window.ethereum === "undefined") {
    throw new Error("MetaMask not installed");
  }

  const accounts = await window.ethereum.request({
    method: "eth_requestAccounts",
  });

  return accounts[0];
};
