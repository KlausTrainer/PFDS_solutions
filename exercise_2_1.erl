%% Exercise 2.1
%%
%% Write a function suffixes of type
%% a list -> a list list
%% that takes a list xs and returns a list of all the suffixes of xs in
%% decreasing order of length.
%% For example,
%%
%%     suffixes [1,2,3,4] = [[1,2,3,4],[2,3,4],[3,4],[4],[]]
%%
%% Show that the resulting list of suffixes can be generated in O(n) time and
%% represented in O(n) space.

-module(exercise_2_1).
-export([suffixes/1]).

suffixes(L) ->
    lists:reverse(suffixes(L, [])).

suffixes([], Acc) ->
    [[]|Acc];
suffixes(L, Acc) ->
    Acc1 = [L|Acc],
    [_|T] = L,
    suffixes(T, Acc1).
