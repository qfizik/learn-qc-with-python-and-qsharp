﻿// Algorithim.qs: Sample code for Deutsch Jozsa algorithim (Chapter 7).
//
// Copyright (c) Sarah Kaiser and Chris Granade.
// Code sample from the book "Learn Quantum Computing with Python and Q#" by
// Sarah Kaiser and Chris Granade, published by Manning Publications Co.
// Book ISBN 9781617296130.
// Code licensed under the MIT License.

namespace DeutschJozsa {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    // tag::is-oracle-balanced[]
    operation IsOracleBalanced(
            oracle : ((Qubit, Qubit) => Unit)              
    ) : Bool {
        using ((control, target) = (Qubit(), Qubit())) {   // <1>
            H(control);                                    // <2>
            X(target);
            H(target);

            oracle(control, target);                       // <3>

            H(target);                                     // <4>
            X(target);

            return MResetX(control) == One;                // <5>
        }
    }
    // end::is-oracle-balanced[]

    // tag::entry-point[]
    operation RunDeutschJozsaAlgorithm() : Unit {
        Fact(not IsOracleBalanced(ZeroOracle), "Test failed for zero oracle."); // <1>
        Fact(not IsOracleBalanced(OneOracle), "Test failed for one oracle.");   // <2>
        Fact(IsOracleBalanced(IdOracle), "Test failed for id oracle.");
        Fact(IsOracleBalanced(NotOracle), "Test failed for not oracle.");

        Message("All tests passed!");                                           // <3>
    }
    // end::entry-point[]

}