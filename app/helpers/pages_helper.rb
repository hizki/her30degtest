module PagesHelper
  def elo_ranking(user1, user2)
    est1 = 1 / (1 + 10 ^ (user1.ranking - user2.ranking) / 400)
    est2 = 1 / (1 + 10 ^ (user2.ranking - user1.ranking) / 400)
    
    sc1 = 0
    sc2 = 0
    
    if user1won = true
      sc1 = 1
    else
      sc2 = 1  
    end
    
    user1.ranking += 10 * (sc1 - est1)
    user2.ranking += 10 * (sc2 - est2)
  end
end
