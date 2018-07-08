classdef P560OCP < OCP
  methods
    function self = P560OCP(system)
      self = self@OCP(system);
    end
    function pathCosts(self,states,algVars,controls,time,endTime,parameters)
      
      self.addPathCost( 1e-6 * controls.T*controls.T' );
      
      e = algVars.p - [-0.5;0;0];
      self.addPathCost(e'*e)
    end
    function arrivalCosts(self,states,endTime,parameters)
    end
    function pathConstraints(self,states,algVars,controls,time,parameters)
    end    
    function boundaryConditions(self,states0,statesF,parameters)
    end
    
    function iterationCallback(self,variables)
    end
    
  end
  
end

