## Constraint specification notes for referential integrity action

# Participation constraint:
- [ ] *Submission* deletion
    - [x] Discussion       	delete cascade
    - [-] AssignedTo		set null
    - [-] PreferenceFor		set null
    - [ ] Author (hasAuthor)	delete cascade
    - [ ] Author (hasContact)	set null
    - [x] RefereeReport		delete cascade
- [x] *Discussion* deletion 		 --> weak entity
- [ ] **TODO**: *AssignedTo* deletion 	 --> relationship entity
- [ ] **TODO**: *PreferenceFor* deletion --> relationship entity
- [ ] *PCMember* deletion
    - [x] PCChair	delete cascade
    - [x] Discussion	delete cascade
    - [-] AssignedTo	set null
    - [-] PreferenceFor	set null
    - [x] RefereeReport	delete cascade
- [x] *Person* deletion
    - [x] PCMember	delete cascade
    - [x] Author	delete cascade
- [ ] *Author* deletion
    - **TODO**: [-] Submission (hasAuthor) 	delete cascade
    - [x] Submission (hasContact)		delete cascade
- [x] *RefereeReport* deletion 		 --> weak entity

# Weak/strong entity constraint:
- [x] *Discussion* delete cascade for identifying entity deletion
- [x] *RefereeReport* delete cascade for identifying entity deletion

# Generalisations/specialisations:
- [x] *Person* deletion --> delete cascade subclasses
- [x] *PCMember* deletion --> delete cascade subclass(es)
