classdef P560System < System
  
  properties
    robot
  end
  methods
    function setupVariables(self)
      self.addState('q',[1,6]);
      self.addState('dq',[1,6]);
      
      self.addControl('T',[1,6]);
      
      self.addAlgVar('p',[3,1]);
      
      mdl_puma560
      self.robot = p560;
      self.robot.fast = 0;
      self.robot.iscsym = 1;
      
    end
    function setupEquation(self,states,algVars,controls,parameters)
      
      % Get access to the system variables
      q = states.q;
      dq = states.dq;
      T = controls.T;
      p = algVars.p;
      
      ddq = self.robot.accel(q,dq,T);
      
      % Define differential equations
      self.setODE('q',dq); 
      self.setODE('dq',ddq);
      
      % constrain p to be endeffector position
      fk = self.robot.fkine(q);
      self.setAlgEquation(p - fk.t);
      
    end
  end
end

