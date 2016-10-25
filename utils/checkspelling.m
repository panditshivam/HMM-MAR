function options = checkspelling (options)

  potential_options = ...  % recognized options
      {'K','order','covtype','zeromean','embeddedlags','pca','pcamar','pcapred','standardise','A','B','V','ndim', ...
      'timelag','exptimelag','orderoffset','symmetricprior','uniqueAR','S','prior','initial_hmm',...
      'state','Fs','cyc','tol','meancycstop','cycstogoafterevent','DirStats',...
      'initcyc','initrep','inittype','Gamma','hmm','fehist','DirichletDiag',...
      'dropstates','repetitions','updateGamma','decodeGamma','keepS_W',...
      'useParallel','useMEX','verbose','cvfolds','cvrep','cvmode','cvverbose',...
      'BIGNbatch','BIGuniqueTrans','BIGprior','BIGcyc','BIGmincyc',... % stochastic
      'BIGundertol_tostop','BIGcycnobetter_tostop','BIGtol','BIGinitrep','BIGdecodeGamma',...
      'BIGforgetrate','BIGdelay','BIGbase_weights','BIGcomputeGamma','BIGverbose',...
      'p','removezeros','completelags','rlowess','numIterations','tol',... % spectra
      'pad','Fs','fpass','tapers','win','to_do','loadings','Nf','MLestimation','level','PriorWeighting'};

  current_options = fieldnames(options);
  unrecognized = current_options(~ismember(current_options,potential_options));

  for j = 1:length(unrecognized)
    % Check edit distance
    distances = cellfun(@(x) EditDistance(unrecognized{j},x),potential_options);
    [d,idx] = min(distances);
    if d <= 2 % Be selective, it will only suggest something based on a minor typo
      fprintf(2,sprintf('%s is not a recognized option - did you mean ''%s''?\n',unrecognized{j},potential_options{idx}));
    else
      fprintf(2,sprintf('%s is not a recognized option\n',opt))
    end

    options = rmfield(options,unrecognized{j});
  end

end


function [V,v] = EditDistance(string1,string2)
  % Edit Distance is a standard Dynamic Programming problem. Given two strings s1 and s2, 
  % the edit distance between s1 and s2 is the minimum number of operations required to convert string 
  % FROM FILE EXCHANGE
  % by : Reza Ahmadzadeh (seyedreza_ahmadzadeh@yahoo.com - reza.ahmadzadeh@iit.it)
  % 14-11-2012

  m=length(string1);
  n=length(string2);
  v=zeros(m+1,n+1);
  for i=1:1:m
      v(i+1,1)=i;
  end
  for j=1:1:n
      v(1,j+1)=j;
  end
  for i=1:m
      for j=1:n
          if (string1(i) == string2(j))
              v(i+1,j+1)=v(i,j);
          else
              v(i+1,j+1)=1+min(min(v(i+1,j),v(i,j+1)),v(i,j));
          end
      end
  end
  V=v(m+1,n+1);
end

