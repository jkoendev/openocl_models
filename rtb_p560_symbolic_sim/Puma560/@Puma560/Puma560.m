classdef Puma560 < SerialLink
 
	properties
	end
 
	methods
		function ro = Puma560()
			objdir = which('Puma560');
			idx = find(objdir == filesep,2,'last');
			objdir = objdir(1:idx(1));
			 
			tmp = load(fullfile(objdir,'@Puma560','matPuma560.mat'));
			 
			ro = ro@SerialLink(tmp.sr);
			 
			 
		end
	end
	 
end
