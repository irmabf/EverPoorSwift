//
//  NoteControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.

/**
 *Any class that implements this protocol must conform no the didAddNote method.
 **/

//MARK:- NoteControllerDelegate

protocol NoteControllerDelegate {
  func didAddNote(note: Note)
  func didEditNote(note: Note)
}


