Verse.delete_all
Verse.create!(
  { id: 1, reference: "1 Cor. 1:2", text: "To the church of God which is in Corinth, to those who have been sanctified in Christ Jesus, the called saints, with all those who call upon the name of our Lord Jesus Christ in every place, [who is] theirs and ours:" },
  { id: 2, reference: "1 Cor. 1:24", text: "But to those who are called, both Jews and Greeks, Christ the power of God and the wisdom of God." },
  { id: 3, reference: "1 Cor. 1:30", text: "But of Him you are in Christ Jesus, who became wisdom to us from God: both righteousness and sanctification and redemption," },
  { id: 4, reference: "1 Cor. 1:9", text: "God is faithful, through whom you were called into the fellowship of His Son, Jesus Christ our Lord." },
  { id: 5, reference: "1 Cor. 10:13", text: "No temptation has taken you except that which is common to man; and God is faithful, who will not allow that you be tempted beyond what you are able, but will, with the temptation, also make the way out, that you may be able to endure [it.]" }

)

ActiveRecord::Base.connection.reset_pk_sequence!("users")
