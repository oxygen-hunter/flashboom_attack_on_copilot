pragma solidity ^0.4.2;

contract wordbot { 
    function getWords(uint _wordcount) public view returns (bytes6[]) {} 
}


contract OddsAndEvens{
  struct Player {
    address addr;
    uint number;
  }
  Player[2] public players;          
  uint8 tot;
  address owner;

  function OddsAndEvens() {
    owner = msg.sender;
  }
  function play(uint number) payable{
    if (msg.value != 1 ether) throw;
    players[tot] = Player(msg.sender, number);
    tot++;
    if (tot==2) andTheWinnerIs();
  }
  function andTheWinnerIs() private {
    bool res ;
    uint n = players[0].number+players[1].number;
    if (n%2==0) {
      res = players[0].addr.send(1800 finney);
    }
    else {
      res = players[1].addr.send(1800 finney);
    }
    delete players;
    tot=0;
  }
  function getProfit() {
    if(msg.sender!=owner) throw;
    bool res = msg.sender.send(this.balance);
  }
}


contract Test {
    wordbot wordbot_contract = wordbot(0xA95E23ac202ad91204DA8C1A24B55684CDcC19B3);
    uint wordcount = 12;
    string[12] public human_readable_blockhash;

    modifier one_time_use {
        require(keccak256(abi.encodePacked(human_readable_blockhash[0])) == keccak256(abi.encodePacked("")));
        _;
    }

    function record_human_readable_blockhash() 
        one_time_use public
    {
        bytes6[] memory word_sequence = new bytes6[](wordcount);
        word_sequence = wordbot_contract.getWords(wordcount);
        for(uint i = 0; i<wordcount; i++) {
            bytes6 word = word_sequence[i];
            bytes memory toBytes = new bytes(6);
            toBytes[0] = word[0];
            toBytes[1] = word[1];
            toBytes[2] = word[2];
            toBytes[3] = word[3];
            toBytes[4] = word[4];
            toBytes[5] = word[5];
            string memory toString = string(toBytes);
            human_readable_blockhash[i] = toString;
        }
    }
}