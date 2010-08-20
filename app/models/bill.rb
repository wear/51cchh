class Bill < ActiveRecord::Base
   belongs_to :billable, :polymorphic => true    
end
