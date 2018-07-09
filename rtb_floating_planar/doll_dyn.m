function xd = doll_dyn(t,x,robot,ode_fun) 
% simulate without motor input (rag doll)
  n = robot.n; 
  qb = x(1:n)'; 
  qdb = x(n+1:2*n)'; 

  qddb = ode_fun(qb,qdb,0*ones(robot.n,1)); 

  qddb = full(qddb);

  xd = [x(n+1:2*n,1); qddb]; 
end