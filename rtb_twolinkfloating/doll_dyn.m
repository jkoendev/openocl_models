function xd = doll_dyn(t,x,robot,ode_fun) 
  
% simulate without motor input (rag doll)

  floor_height = 1;

  n = robot.n; 
  q = x(1:n)'; 
  qd = x(n+1:2*n)'; 

  % contact force
  p_end = transl(robot.fkine(q));
  tau_contact = 0;
  
  if p_end(3) < floor_height
    E = 100000;
    d = floor_height-p_end(3); % penetration distance
    
    contact_force = d*E;
    
    jac_end = robot.jacob0(q);
    jac_end_z = jac_end(3,:);
    tau_contact = jac_end_z' * contact_force;
  end
  
  qdd = ode_fun(q, qd, tau_contact + 0*ones(robot.n,1)); 

  qdd = full(qdd);

  xd = [x(n+1:2*n,1); qdd]; 
end