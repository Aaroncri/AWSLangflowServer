resource "aws_instance" "jump_box" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jump_box_key.key_name
  vpc_security_group_ids = [aws_security_group.SG_jump_box.id]
  subnet_id = aws_subnet.main-public.id
  tags = {
    Name = "Jump Box"
  }
}
