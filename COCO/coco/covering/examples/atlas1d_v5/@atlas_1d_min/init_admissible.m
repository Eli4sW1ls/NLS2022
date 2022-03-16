function [prob, atlas, cseg] = init_admissible(atlas, prob, cseg, S)
%INIT_ADMISSIBLE  Remove inadmissible directions.
%
% Restrict continuation to admissible directions from the initial chart.
% Flush and terminate if no admissible directions.

% Copyright (C) Frank Schilder, Harry Dankowicz
% $Id: init_admissible.m 3087 2019-04-04 19:54:09Z hdankowicz $

flags = (S.dir_flags==atlas.IsAdmissible);
if S.ep_flag==1 && any(flags)
  cseg.curr_chart.s = cseg.curr_chart.s(flags); % Admissible directions
else
  [prob, atlas, cseg] = init_admissible@AtlasBase(atlas, prob, cseg, S);
end

end
