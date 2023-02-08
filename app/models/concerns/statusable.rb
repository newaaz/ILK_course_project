module Statusable
  extend ActiveSupport::Concern

  included do
    include AASM

    enum status: { received: 0, accepted: 1, rejected: 2, paid: 3 }

    aasm column: :status, enum: true do
      state :received, initial: true
      state :accepted, :rejected, :paid
  
      event :accept do
        transitions from: :received, to: :accepted
      end
  
      event :reject do
        transitions from: :received, to: :rejected
      end
  
      event :pay do
        transitions from: :accepted, to: :paid
      end
    end
  
    def change_status(status_action)
      case  status_action
        when 'accept'
          accept_order!
        when 'reject'
          reject_order!
        when 'pay'
          pay_order!
        end  
    end

    private  

    def pay_order!
      #TODO: Test Service for order pay
      self.paid!
    end
  
    def accept_order!
      self.accepted!
    end
  
    def reject_order!
      self.rejected!
    end
  end
end
