require './lib/config.rb'



SCHEDULER.every '5s' do

   q = Names.new "http://hanlon.herokuapp.com/hanlon/api/v1/policy"
   current = q.query
   
 
  buzzword_counts = Hash.new()
 

  resp = current[:response]
  resp_len = resp.length
  
  for i in (0..(resp_len-1))
    #keys = get_Keys(resp[i])
    resp[i][:@classname].slice! "ProjectHanlon::PolicyTemplate::"
    buzzword_counts[i] = {  
			    uuid: resp[i][:@uuid] , 
                            
                            classname:  resp[i][:@classname] , 
                            uri: resp[i][:@uri],
			    uuids: resp[i][:@uuid][0,15], 
                            
                            noun: resp[i][:@noun],
                            bindcounter: resp[i][:@bind_counter], 
                            linenumber: resp[i][:@line_number],
                            
                            din: "policylistnum#{i}"



			   

                          
    
    
                          }
    
    
    
  end

  


 send_event('policyList', { items: buzzword_counts.values })

end

