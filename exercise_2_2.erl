%% Exercise 2.2 (Andersson [And91])
%%
%% In the worst case, member performs approximately 2d comparisons, where d is
%% the depth of the tree. Rewrite member to take no more than d + 1 comparisons
%% by keeping track of a candidate element that might be equal to the query
%% element (say, the last element for which < returned false or =< returned
%% true) and checking for equality only when you hit the bottom of the tree.

-module(exercise_2_2).
-export([member/3, test_member/0]).

%% The Values in Treedict must be of the structure
%% {NodeValue, LeftChildPtr, RigthChildPtr}, while NodeValue is assumed to
%% be comparable by the <, >, =:=, etc. operators.

%% @spec member(X, TreeDict::dictionary(), RootPtr)
member(X, TreeDict, RootPtr) ->
    member(X, TreeDict, RootPtr, nil).

member(X, TreeDict, NodePtr, Candidate) ->
    case NodePtr of
    nil ->
        if
        Candidate =/= nil ->
            case dict:fetch(Candidate, TreeDict) of
            {X, _LeftChildPtr, _RightChildPtr} ->
                Candidate;
            _ ->
                nil
            end;
        true ->
            nil
        end;
    _ ->
        case dict:fetch(NodePtr, TreeDict) of
        {NodeValue, LeftChildPtr, _RightChildPtr} when X < NodeValue ->
            member(X, TreeDict, LeftNodePtr, Candidate);
        {_NodeValue, _LeftChildPtr, RightChildPtr} ->
            Candidate1 = NodePtr,
            member(X, TreeDict, RightChildPtr, Candidate1)
        end
    end.


test_member() ->
    D = dict:from_list([{1, {"Der", nil, nil}}, {11, {"müde", nil, nil}}, {3, {"Leib", nil, nil}}, {9, {"findet", nil, nil}}, {7, {"ein", nil, nil}}, {4, {"Schlafkissen", 2, 6}}, {16, {"überall", 8, nil}}, {6, {"doch", 5, 7}}, {14, {"wenn", 13, 15}}, {5, {"der", nil, nil}}, {2, {"Geist", 1, 3}}, {11, {"müde", nil, nil}}, {10, {"ist", 9, 11}}, {15, {"wo", nil, nil}}, {13, {"soll", nil, nil}}, {8, {"er", 4, 12}}, {12, {"ruhen", 10, 14}}]),
    T1 = member("Schlafkissen", D, 16) =:= 4,
    T2 = member("überall", D, 16) =:= 16,
    T3 = member("foo", D, 16) =:= nil,
    T4 = member("müde", D, 16) =:= 11,
    T5 = member("doch", D, 16) =:= 6,
    T6 = member("bar", D, 16) =:= nil,
    Pred = fun(E) -> case E of true -> true; _ -> false end end,
    L1 = [T1, T2, T3, T4, T5, T6],
    case lists:dropwhile(Pred, L1) of
    [] ->
        io:format("All tests passed successfully.~n");
    L2 ->
        io:format("Test ~p failed.~n", [length(L1) - length(L2) + 1])
    end.
