Balance = Balance or {}

function Balance.getUserAccount(username)
    local coinBalance = ModData.get("CoinBalance")
    if not coinBalance then return nil end
    return coinBalance[username]
end

function Balance.getUserBalance(username)
    local account = Balance.getUserAccount(username)
    local coin = 0
    local specialCoin = 0
    if not account then return coin,specialCoin end
    if account.coin then
        coin = account.coin
    end
    if account.specialCoin then
        specialCoin = account.specialCoin
    end
    return coin,specialCoin
end

function Balance.getAccountsList()
    local accounts = {}
    local coinBalance = ModData.get("CoinBalance")
    if not coinBalance then return accounts end
    for k,v in pairs(coinBalance) do
        table.insert(accounts,k)
    end
    return accounts
end

-- Función para reiniciar el balance de un usuario específico
function Balance.resetUserBalance(username)
    local coinBalance = ModData.get("CoinBalance") or {}
    if coinBalance[username] then
        coinBalance[username] = {
            coin = 0,
            specialCoin = 0
        }
        ModData.add("CoinBalance", coinBalance)
        return true
    end
    return false
end

-- Función para eliminar completamente la cuenta de un usuario
function Balance.removeUserAccount(username)
    local coinBalance = ModData.get("CoinBalance") or {}
    if coinBalance[username] then
        coinBalance[username] = nil
        ModData.add("CoinBalance", coinBalance)
        return true
    end
    return false
end

-- Función para reiniciar TODOS los balances
function Balance.resetAllBalances()
    ModData.add("CoinBalance", {})
end