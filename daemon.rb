require 'cardano_wallet'
@cw = CardanoWallet.new({port: 8093})

def store_treasury(epoch)
  puts "Going into epoch #{epoch}..."
  puts "Next epoch will be: #{epoch + 1}"
  treasury = `cardano-cli shelley query ledger-state --testnet-magic 42 | jq .esAccountState._treasury`
  puts "Treasury: #{treasury}"
  open('treasury.out', 'a') { |f|
    f.puts "Epoch: #{epoch}"
    f.puts "Treasury: #{treasury}"
    f.puts "---"
  }
end

store_treasury(@cw.misc.network.information['node_tip']['epoch_number'])

next_epoch = @cw.misc.network.information['next_epoch']['epoch_number']
while 1
  current_epoch = @cw.misc.network.information['node_tip']['epoch_number']
  if current_epoch == next_epoch
    store_treasury(current_epoch)
    next_epoch += 1
  end
  sleep 5
end
